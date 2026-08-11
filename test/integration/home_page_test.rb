# frozen_string_literal: true

require "test_helper"

class HomePageTest < ActionDispatch::IntegrationTest
  test "landing page renders the marketing sections" do
    get root_path

    assert_response :success
    assert_select "h1", text: /Your team's signal/
    assert_select "#features .md-feature", count: 6
    assert_select "#pricing .md-price-card", count: 3
    assert_select "#faq details", count: 6
    assert_select "#waitlist form[action=?]", leads_path
    assert_select "input[name='lead[email]']"
    assert_select "input[name='lead[name]']"
  end

  test "landing page lead signup stores a lead and redirects with a notice" do
    assert_difference "Lead.count", 1 do
      post leads_path, params: { lead: { name: "Ada Lovelace", email: "ADA@Example.com " } }
    end

    lead = Lead.last
    assert_equal "ada@example.com", lead.email
    assert_equal "Ada Lovelace", lead.name
    assert_equal "landing-page", lead.source

    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
    assert_select ".beacon-waitlist__success"
  end

  test "duplicate email does not create a second lead" do
    Lead.create!(email: "ada@example.com", name: "Ada")

    assert_no_difference "Lead.count" do
      post leads_path, params: { lead: { email: "ADA@example.com " } }
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
    assert_select ".beacon-waitlist__error"
  end

  test "invalid email is rejected without creating a lead" do
    assert_no_difference "Lead.count" do
      post leads_path, params: { lead: { email: "not-an-email" } }
    end
  end

  test "lead inbox is not reachable by guests" do
    get admin_leads_path
    assert_response :not_found
  end
end
