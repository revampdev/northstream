require "application_system_test_case"

class TicketsTest < ApplicationSystemTestCase
  setup do
    @ticket = tickets(:one)
  end

  test "visiting the index" do
    visit tickets_url
    assert_selector "h1", text: "Tickets"
  end

  test "creating a Ticket" do
    visit tickets_url
    click_on "New Ticket"

    fill_in "Amount", with: @ticket.amount
    fill_in "Stream", with: @ticket.stream_id
    fill_in "Token", with: @ticket.token
    fill_in "User", with: @ticket.user_id
    click_on "Create Ticket"

    assert_text "Ticket was successfully created"
    assert_selector "h1", text: "Tickets"
  end

  test "updating a Ticket" do
    visit ticket_url(@ticket)
    click_on "Edit", match: :first

    fill_in "Amount", with: @ticket.amount
    fill_in "Stream", with: @ticket.stream_id
    fill_in "Token", with: @ticket.token
    fill_in "User", with: @ticket.user_id
    click_on "Update Ticket"

    assert_text "Ticket was successfully updated"
    assert_selector "h1", text: "Tickets"
  end

  test "destroying a Ticket" do
    visit edit_ticket_url(@ticket)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Ticket was successfully destroyed"
  end
end
