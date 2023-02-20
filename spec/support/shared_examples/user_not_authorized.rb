shared_examples 'redirect to home with error message' do
  it 'renders index' do
    expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
  end
end
