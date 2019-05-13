require 'rails_helper'

RSpec.describe Book do

  describe "relationships" do
    it { should have_many :book_authors }
    it { should have_many(:authors).through(:book_authors) }
  end

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :pages }
    it { should validate_presence_of :year_pub }
    it { should validate_presence_of :cover_img }
  end

  before :each do
    @book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
    @book_2 = Book.create!(title: "Title 2", pages: 200, year_pub: 1902, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
    @book_3 = Book.create!(title: "Title 3", pages: 300, year_pub: 1903, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")

    @author_1 = @book_1.authors.create!(name: "Author 1", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
    @author_2 = @book_1.authors.create!(name: "Author 2", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
    @author_3 = @book_2.authors.create!(name: "Author 3", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
    @author_4 = @book_3.authors.create!(name: "Author 4", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")

    @user_1 = User.create!(name: "User One")
    @user_2 = User.create!(name: "User Two")

    @review_1 = @book_1.reviews.create!(title: "Review 1", rating: 1, body: "stuff 1", user: @user_1 )
    @review_2 = @book_1.reviews.create!(title: "Review 2", rating: 2, body: "stuff 2", user: @user_2 )

    @review_3 = @book_2.reviews.create!(title: "Review 1", rating: 3, body: "stuff 3", user: @user_1 )
    @review_4 = @book_2.reviews.create!(title: "Review 2", rating: 3, body: "stuff 4", user: @user_2 )

    @review_5 = @book_3.reviews.create!(title: "Review 1", rating: 4, body: "stuff 5", user: @user_1 )

  end

  describe "instance methods" do
    it "should calculate average rating for each book" do
      expect(@book_1.average_rating).to eq(1.5)
      expect(@book_2.average_rating).to eq(3)
      expect(@book_3.average_rating).to eq(4)
    end

    it "should calculate count of reviews for each book" do
      expect(@book_1.total_reviews).to eq(2)
      expect(@book_2.total_reviews).to eq(2)
      expect(@book_3.total_reviews).to eq(1)
    end

    it "can find top reviews for each book for a specific author" do
      expect(@book_1.find_top_review).to eq(@review_2)
    end
  end

  describe "class methods" do
    it "should show all book titles" do
      expect(Book.find_titles).to eq(["Title 1", "Title 2", "Title 3"])
    end
    it "should sort all books by average rating in ascending order" do
      expect(Book.avg_rating("ASC")).to eq([@book_1, @book_2, @book_3])
    end
    it "should sort all books by average rating in descending order" do
      expect(Book.avg_rating("DESC")).to eq([@book_3, @book_2, @book_1])
    end
    it "should sort all books by number of pages in ascending order" do
      expect(Book.sort_by_pages("ASC")).to eq([@book_1, @book_2, @book_3])
    end
    it "should sort all books by number of pages in descending order" do
      expect(Book.sort_by_pages("DESC")).to eq([@book_3, @book_2, @book_1])
    end
    it "should sort all books by number of reviews in descending order" do
      expect(Book.sort_by_reviews("DESC")).to eq([@book_1, @book_2, @book_3])
    end
  end
end
# before :each do
#   @book_1 = Book.create!(title: "Title 1", pages: 100, year_pub: 1901, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
#   @book_2 = Book.create!(title: "Title 2", pages: 200, year_pub: 1902, cover_img: "https://media.wired.com/photos/5be4cd03db23f3775e466767/master/pass/books-521812297.jpg")
#   @book_3 = Book.create!(title: "Title 3", pages: 300, year_pub: 1903)
#   @book_4 = Book.create!(title: "Title 4", pages: 400, year_pub: 1904)
#   @book_5 = Book.create!(title: "Title 5", pages: 500, year_pub: 1905)
#
#   @author_1 = Author.create!(name: "Author 1", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
#   @author_2 = Author.create!(name: "Author 2", author_img: "https://banner2.kisspng.com/20180516/zce/kisspng-shadow-person-dungeons-dragons-silhouette-art-5afc1fa5cf7d87.5508397315264726138499.jpg")
#
#   BookAuthor.create!(book: @book_1, author: @author_1)
#   BookAuthor.create!(book: @book_1, author: @author_2)
#
#   BookAuthor.create!(book: @book_2, author: @author_1)
#   BookAuthor.create!(book: @book_2, author: @author_2)
#
#   BookAuthor.create!(book: @book_3, author: @author_1)
#
#   BookAuthor.create!(book: @book_4, author: @author_1)
#
#   @user_1 = User.create!(name: "User One")
#   @user_2 = User.create!(name: "User Two")
#   @user_3 = User.create!(name: "User Three")
#   @user_4 = User.create!(name: "User Four")
#
#   @review_1 = @book_1.reviews.create!(title: "Review 1", rating: 1, body: "stuff 1", user: @user_1)
#   @review_2 = @book_1.reviews.create!(title: "Review 2", rating: 2, body: "stuff 2", user: @user_2)
#   @review_3 = @book_1.reviews.create!(title: "Review 3", rating: 3, body: "stuff 3", user: @user_3)
#
#   @review_4 = @book_2.reviews.create!(title: "Review 4", rating: 1, body: "stuff 4", user: @user_1)
#   @review_5 = @book_2.reviews.create!(title: "Review 5", rating: 2, body: "stuff 5", user: @user_2)
#
#   @review_6 = @book_3.reviews.create!(title: "Review 6", rating: 5, body: "stuff 6", user: @user_2)
#
#   # @review_7 = @book_4.reviews.create!(title: "Review 7", rating: 2, body: "stuff 7", user: @user_2)
# end
