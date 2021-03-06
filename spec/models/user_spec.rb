require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new( name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar",
                      bio: "lorem ipsum dolor")
    @user.avatar.attach(io: File.open('app/assets/images/default-user.png'),
                           filename: 'default.png', content_type: 'image/png')
  end

  it "should be valid" do
    expect(@user).to be_valid
  end

  it "should have avatar image" do
    @user.avatar.purge
    expect(@user).not_to be_valid
  end

  it "image shuld have a correct type" do
    @user.avatar.attach(io: File.open('app/assets/files/not_an_image.txt'),
                        filename: 'text.txt', content_type: 'text/plain')
    correct_types =   %w[image/png image/jpeg]
    expect(@user).not_to be_valid unless @user.avatar.content_type.in?( correct_types )
  end

  it "shold have vaild name" do
    @user.name = " "
    expect(@user).not_to be_valid
  end

  it "name should not be too long" do
    @user.name = "a" * 51
    expect(@user).not_to be_valid
  end

  it "bio should not be too long" do
    @user.bio = "a" * 1001
    expect(@user).not_to be_valid
  end

  it "should have valid email" do
    @user.email = "    "
    expect(@user).not_to be_valid
  end

  it "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    expect(@user).not_to be_valid
  end

  it "email validation should reject invalid addresses" do
	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      expect(@user).not_to be_valid
    end
  end

  it "email addresses should be unique" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
    @user.save
    expect(duplicate_user).not_to be_valid
	end

	it "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    expect(mixed_case_email.downcase).to eq(@user.reload.email)
  end

	it "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    expect(@user).not_to be_valid
	end

	it "password should have a minimum length" do
		@user.password = @user.password_confirmation = "a" * 5
    expect(@user).not_to be_valid
	end
end
