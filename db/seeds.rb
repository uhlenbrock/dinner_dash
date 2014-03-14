['Appetizers', 'Salads', 'Entrees', 'Desserts'].each do |c|
  Category.create title: c
end

Item.create title: 'Cheeseburger', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit', category: Category.find_by_title('Entrees'), price: 10
Item.create title: 'Cobb Salad', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit', category: Category.find_by_title('Salads'), price: 10
Item.create title: 'Shrimp Cocktail', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit', category: Category.find_by_title('Appetizers'), price: 5
Item.create title: 'Cheesecake', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit', category: Category.find_by_title('Desserts'), price: 10

User.create name: 'Bobby Uhlenbrock', email: 'bobby@helloample.com', password: 'dinnerdash', password_confirmation: 'dinnerdash', admin: true
User.create name: 'Test User', email: 'test@user.com', password: 'dinnerdash', password_confirmation: 'dinnerdash', admin: false

Order.create items: [Item.find_by_title('Cheeseburger'), Item.find_by_title('Cheesecake')], user: User.find_by_email('test@user.com')