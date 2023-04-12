class ProductService
  include HTTParty

  base_uri 'https://dummyjson.com'

  def self.import_products
    response = get('/products')

    if response.success?
      response.parsed_response.each do |product|
        Product.create(name: product['name'], description: product['description'], price: product['price'])
      end
    end
  end
end
