module OrdersHelper

  def order_actions(order)
    actions = []
    actions << link_to('Edit', edit_order_path(order))
    actions << link_to('Destroy', order, method: :delete, data: { confirm: 'Are you sure?' })
    actions << link_to('Cancel', transition_order_path(order, 'cancelled')) if order.cancelable?
    actions << link_to('Mark as paid', transition_order_path(order, 'paid')) if order.ordered?
    actions << link_to('Mark as complete', transition_order_path(order, 'completed')) if order.paid?
    actions.join(' | ').html_safe
  end

end
