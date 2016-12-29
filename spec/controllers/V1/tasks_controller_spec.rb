require 'rails_helper'
require 'webmock/rspec'

describe V1::TasksController, :type => :controller do
  let!(:project) { create(:project) }

  describe "PUT update_task_state" do
    let!(:task) { create(:task, project_id: project.id) }
    let!(:update_params) do { project_id: project.id, task_id: task.id, state: "in-progress" } end

    it "responds with 200" do
      put 'update_task_state', update_params
      expect(response.status).to eql(200)
    end

    it "successfully updates the task" do
      expect(task.state).to eql("todo")

      put 'update_task_state', update_params
      body = JSON.parse(response.body)

      task.reload
      expect(body["state"]).to eql("in-progress")
      expect(task.state).to eql("in-progress")
    end

    context "when a task is updated to complete" do
      let!(:update_params) do { project_id: project.id, task_id: task.id, state: "done" } end

        before do
          stub_request(:post, "https://api.twilio.com/2010-04-01/Accounts/ACb44804bc4b710ac8dba26b98b0c60eae/Messages.json").
            with(:headers => {'Accept'=>'application/json', 'Accept-Charset'=>'utf-8', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic QUNiNDQ4MDRiYzRiNzEwYWM4ZGJhMjZiOThiMGM2MGVhZTo2MmI1NTUwOTQwMzEwZjRmYzU3YmExOTg0NDcyYmE3MA==', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'twilio-ruby/4.11.1 (ruby/x86_64-darwin16 2.3.0-p0)'}).
          to_return(:status => 200, :body => "", :headers => {})
        #   stub_request(:post, "https://api.twilio.com/2010-04-01/Accounts/ACb44804bc4b710ac8dba26b98b0c60eae/Messages.json").
        #  with(:body => {"Body"=>"Hooray! Task Complete!", "From"=>"+15412554232", "To"=>"+15624726279"},
        #       :headers => {'Accept'=>'application/json', 'Accept-Charset'=>'utf-8', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic QUNiNDQ4MDRiYzRiNzEwYWM4ZGJhMjZiOThiMGM2MGVhZTo2MmI1NTUwOTQwMzEwZjRmYzU3YmExOTg0NDcyYmE3MA==', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'twilio-ruby/4.11.1 (ruby/x86_64-darwin16 2.3.0-p0)'}).
        #  to_return(:status => 200, :body => "", :headers => {})
        end

      it "sends an sms message when updated to done" do
        put 'update_task_state', update_params        #
        expect(a_request(:post, "https://api.twilio.com")).to have_been_made.times(1)
        expect(task).to receive(:send_message_via_sms).with("Hooray! Task Complete!")
      end
    end
  end

end
