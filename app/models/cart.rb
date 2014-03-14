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
    Item.find @session[:item_ids]
  end

  def items_count
    @session[:item_ids].size
  end

  def empty?
    @session[:item_ids].empty?
  end

end
