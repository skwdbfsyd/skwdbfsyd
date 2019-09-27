# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  phone_number           :string(255)
#  device_token           :string(255)
#  app_version            :integer
#  abstractable_type      :string(255)
#  abstractable_id        :integer
#  email                  :string(255)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string(255)      default("email"), not null
#  uid                    :string(255)      default(""), not null
#  tokens                 :json
#
# Indexes
#
#  index_users_on_abstractable_type_and_abstractable_id  (abstractable_type,abstractable_id)
#  index_users_on_email                                  (email) UNIQUE
#  index_users_on_reset_password_token                   (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider                       (uid,provider) UNIQUE
#

require 'rails_helper'

describe User do
  describe 'validations' do
    subject { build :user }
    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }

    context 'when was created with regular login' do
      subject { build :user }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive.scoped_to(:provider) }
      it { is_expected.to validate_presence_of(:email) }
    end
  end

  context 'when was created with regular login' do
    let!(:user) { create(:user) }
    let(:full_name) { user.full_name }

    it 'returns the correct name' do
      expect(full_name).to eq(user.username)
    end
  end
end
