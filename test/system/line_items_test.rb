require "application_system_test_case"

class LineItemsTest < ApplicationSystemTestCase
  setup do
    @line_item = line_items(:one)
  end

  test "visiting the index" do
    visit line_items_url
    assert_selector "h1", text: "Line Items"
  end

  test "creating a Line item" do
    visit line_items_url
    click_on "New Line Item"

    fill_in "Amount", with: @line_item.amount
    fill_in "Description", with: @line_item.description
    fill_in "Name", with: @line_item.name
    fill_in "Order", with: @line_item.order_id
    click_on "Create Line item"

    assert_text "Line item was successfully created"
    assert_selector "h1", text: "Line Items"
  end

  test "updating a Line item" do
    visit line_item_url(@line_item)
    click_on "Edit", match: :first

    fill_in "Amount", with: @line_item.amount
    fill_in "Description", with: @line_item.description
    fill_in "Name", with: @line_item.name
    fill_in "Order", with: @line_item.order_id
    click_on "Update Line item"

    assert_text "Line item was successfully updated"
    assert_selector "h1", text: "Line Items"
  end

  test "destroying a Line item" do
    visit edit_line_item_url(@line_item)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Line item was successfully destroyed"
  end
end
