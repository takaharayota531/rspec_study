require 'rails_helper'

RSpec.describe Note do

  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project,owner: user) }




  it "generates associated data from a factory" do
    note=FactoryBot.create(:note)
    puts "note's project is #{note.project.inspect}"
    puts "note'user is #{note.user.inspect}"
  end

  it "is valid with a user,project,and message" do
    note=described_class.new(
      message: "sample",
      user:,
      project:
    )
    expect(note).to be_valid
  end

  it "is invalid without a message"do
    note=described_class.new(message: nil)
    expect(note).not_to be_valid
    expect(note.errors[:message]).to include("can't be blank")
  end

  it "is invalid without a message2"do
    note=described_class.new(
      message: nil,
      user:,
      project:)
    expect(note).not_to be_valid
    expect(note.errors[:message]).to include("can't be blank")
  end

  # 文字列に一致するメッセージを検索する
  describe "search message for a term" do

    let!(:note1) do
      FactoryBot.create(
        :note,
        project:,
        user:,
        message: "This is the first note.",
        )
    end
    let!(:note2) do
      FactoryBot.create(
        :note,
        project:,
        user:,
        message: "This is the second note.",
        )
    end
    let!(:note3) do
      FactoryBot.create(
        :note,
        project:,
        user:,
        message: "First, preheat the oven.",
        )
    end


    # 一致するデータが見つかる時
    context "when a match is found" do
      it "returns notes that match the search term" do
      expect(described_class.search("first")).to include(note1,note3)
      end
    end

    # 一致するデータが一件も見つからない時
    context "when no match is found" do
      it "returns an empty collection" do

        expect(described_class.search("message")).to be_empty
        expect(Note.count).to eq 3
      end

    end

  end

  end