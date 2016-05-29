feature 'reviewing' do
  before do
    sign_up
    add_restaurant
  end

  scenario 'allows users to leave a review using a form' do
     visit '/restaurants'
     click_link 'Review KFC'
     fill_in "Thoughts", with: "so so"
     select '3', from: 'Rating'
     click_button 'Leave Review'

     expect(current_path).to eq '/restaurants'
     expect(page).to have_content('so so')
  end

  scenario 'displays an average rating for all reviews' do
    leave_review('So so', '3')
    click_link 'Sign out'
    sign_up(params = {
      email: "test2@example.com",
      password: "testtest",
      password_confirmation: "testtest"})
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: ★★★★☆')
  end
end
