require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    describe 'saves' do
      it 'should save' do
        @category = Category.create(name: 'Automotive')
        @product = Product.create(
          name: 'Honda Civic',
          price: 20000,
          category: @category,
          quantity: 10
        )
      expect(@product.errors.full_messages).to be_empty
      end
    end

    # can do it
    describe 'name' do
      it 'should require a name' do
        @category = Category.create(name: 'Automotive')
        @product = Product.create(
          price: 20000,
          category: @category,
          quantity: 10
        )
      expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end
    
    # or can do before do first
    describe 'price' do
      before do
        @category = Category.create(name: 'Automotive')
        @product = Product.create(
          name: 'Honda Civic',
          category: @category,
          quantity: 10
        )
      end
      it('should require a price') do
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
    end

    describe 'quantity' do
      before do
        @category = Category.create(name: 'Automotive')
        @product = Product.create(
          name: 'Honda Civic',
          price: 20000,
          category: @category,
        )
      end
      it('should require a quantity') do
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    describe 'category' do
      before do
        @product = Product.create(
          name: 'Honda Civic',
          price: 20000,
          category: @category,
          quantity: 10
        )
      end
      it('should require a category') do
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end

  end
end
