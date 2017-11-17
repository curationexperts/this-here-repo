FactoryBot.define do
  factory :etd do
    transient do
      user { FactoryBot.create(:user) }
      pdf  { nil }
    end

    # give the user edit access
    after(:build) do |work, evaluator|
      work.apply_depositor_metadata(evaluator.user.user_key)

      if evaluator.pdf
        actor = Hyrax::Actors::FileSetActor.new(FileSet.create, evaluator.user)
        actor.create_metadata({})
        actor.create_content(evaluator.pdf)
        actor.attach_to_work(work)
      end
    end

    title ['Comet in Moominland']

    factory :public_etd do
      visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
    end

    factory :moomins_thesis do
      creator          ['Moomin', 'Hemulen']
      date             ['199?']
      date_created     [Date.parse('2016-12-25')]
      date_label       ['Winter in Moomin Valley']
      date_modified    DateTime.current
      date_uploaded    DateTime.current
      degree           ['M.Phil.']
      department       ['Coin Collecting']
      description      ['Winter', 'Collecting']
      identifier       ['Moomin_123']
      institution      ['Moomin Valley Community College']
      keyword          ['moomin', 'snork', 'hattifattener']
      language         ['Finnish', 'Swedish']
      license          [RDF::URI('https://creativecommons.org/licenses/by-sa/4.0/')]
      orcid_id         ['0000-0001-2345-6789', '0000-0002-1825-0097']
      school           ['School of Hattifattener Studies']
      source           ['Too-Ticky', 'Snufkin']
      subject          ['Moomins', 'Snorks']
      resource_type    ['thesis']
      rights_note      ['For the exclusive viewing of Little My.',
                        'Moomin: do not read this.']
      rights_statement [RDF::URI('http://rightsstatements.org/vocab/NKC/1.0/')]
    end

    # https://dspace.mit.edu/handle/1721.1/11173
    factory :shannon_mit do
      creator    ['Shannon, Claude Elwood']
      date       ['1940']
      title      ['A symbolic analysis of relay and switching circuits']
      identifier ['10.5555/1234']

      factory :shannon_mit_bad_bibtex do
        creator ['Shannon, Claude Elwood, 1916-']
      end
    end

    # https://dspace.mit.edu/handle/1721.1/11173
    factory :shannon_weaver do
      creator    ['Shannon, Claude Elwood', 'Weaver, Warren']
      date       ['1949']
      title      ['The Mathematical Theory of Communication']
      identifier ['10.5555/1235']
    end
  end
end
