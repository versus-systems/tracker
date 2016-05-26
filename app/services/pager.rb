class Pager
  attr_reader :collection, :page_size

  def initialize collection, page, page_size
    @page = page.try(:to_i) || 1
    raise ArgumentError, 'Page cannot be <= 0' if @page < 1
    @collection = collection
    @page_size = page_size.try(:to_i) || 25
    @page_size = 25 if @page_size < 1
  end

  def results
    collection.limit(page_size).offset(offset)
  end

  def total_count
    @total_count ||= collection.count
  end

  def total_page_count
    @total_page_count ||= (total_count.to_f / page_size).ceil
  end

  def page
    [total_page_count, @page].min
  end

  def offset
    [(page - 1) * page_size, 0].max
  end
end
