require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "creating a Product" do
    visit products_url
    click_on "New Product"

    fill_in "Amount", with: @product.amount
    fill_in "Name", with: @product.name
    fill_in "Stream", with: @product.stream_id
    click_on "Create Product"

    assert_text "Product was successfully created"
    assert_selector "h1", text: "Products"
  end

  test "updating a Product" do
    visit product_url(@product)
    click_on "Edit", match: :first

    fill_in "Amount", with: @product.amount
    fill_in "Name", with: @product.name
    fill_in "Stream", with: @product.stream_id
    click_on "Update Product"

    assert_text "Product was successfully updated"
    assert_selector "h1", text: "Products"
  end

  test "destroying a Product" do
    visit edit_product_url(@product)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Product was successfully destroyed"
  end
end
