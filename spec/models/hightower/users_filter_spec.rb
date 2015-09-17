module Hightower
  RSpec.describe UsersFilter do
    describe "#perform" do
      it "returns users with labels matching the given query" do
        valid_matches = [ create(:user, name: 'Ben'),
                  create(:user, name: 'ben'),
                  create(:user, name: 'benjamin'),
                  create(:user, name: 'sirbenjamin') ]

        invalid_match = create(:user, name: 'Mick')
        search = UsersFilter.new(User.all)

        result = search.perform(query: 'ben')

        expect(result).to eq valid_matches
      end
    end
  end
end