class Cart

  def initialize(session)
    @session = session
    @session[:item_ids] ||= []
  end

  # -------------------------------------- Instance Methods

  def add_item(item)
    @session[:item_ids] << item.id
  end

  def remove_item(item)
    @session[:item_ids].delete(item.id)
  end

  def items
    @items ||= begin
      returned_items = Item.where(id: item_ids)
      collected_items = returned_items.clone.clear
      item_ids.each do |i|
        collected_items << returned_items.detect { |d| d.id == i.to_i }
      end
      collected_items
    end
  end

  def item_ids
    @session[:item_ids]
  end

  def items_count
    @session[:item_ids].size
  end

  def empty?
    @session[:item_ids].empty?
  end

  def empty!
    @session[:item_ids] = []
  end

  def total
    items.sum(&:price)
  end

  def calculate_earliest_pickup_at
    @calculate_earliest_pickup_at ||= Order.calculate_earliest_pickup_at(items)
  end

end
