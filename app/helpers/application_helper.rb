module ApplicationHelper
  def authenticated?
    session.has_key? :customer_id
  end
end
