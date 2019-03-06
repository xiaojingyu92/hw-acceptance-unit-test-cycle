require 'rails_helper'

describe MoviesController do
  describe 'Search movies by the same director' do
    it 'should call Movie.same_director' do
      expect(Movie).to receive(:same_director).with('Aladdin')
      get :search_same_director, { title: 'Aladdin' }
    end

    it 'should assign similar movies if director exists' do
      movies = ['Seven', 'The Social Network']
      Movie.stub(:same_director).with('Seven').and_return(movies)
      get :search_same_director, { title: 'Seven' }
      expect(assigns(:same_director)).to eql(movies)
    end

    it "should redirect to home page if director isn't known" do
      Movie.stub(:same_director).with('No name').and_return(nil)
      get :search_same_director, { title: 'No name' }
      expect(response).to redirect_to(movies_path)
    end
  end

    describe '#create' do
        movie_params={"title"=>"Alien"}
        
        it 'should call the model method that create a Movie' do
            expect(Movie).to receive(:create!).with(movie_params).and_return(Movie.new(movie_params))
            post :create, {:movie => movie_params}
        end
        
        it 'should redirect to homepage'do
            post :create, {:movie => movie_params}
            expect(response).to redirect_to(movies_path)
        end

        it 'should display the message was successfully created.'do
            post :create, {:movie => movie_params}
            expect(flash[:notice]).to eq("#{movie_params["title"]} was successfully created.")
        end
        
    end
    describe '#update' do
        movie_params={"title"=>"Alien"}
        it 'should call the model method that update a Movie' do
            movie=FactoryGirl.create(:movie,:title =>'title1' ,:director => 'George Lucas')
            Movie.stub(:find).and_return(movie)
            expect(movie).to receive(:update_attributes!).with(movie_params).and_return(movie.update_attributes!(movie_params))
            put :update, {:id=>1,:movie => movie_params}
        end
        
        it 'should redirect to homepage'do
            movie=FactoryGirl.create(:movie,:title =>'title1' ,:director => 'George Lucas')
            Movie.stub(:find).and_return(movie)
            put :update, {:id=>movie.id,:movie => movie_params}
            expect(response).to redirect_to(movie_path(movie))
        end

        it 'should display the message was successfully created.'do
            movie=FactoryGirl.create(:movie,:title =>'title1' ,:director => 'George Lucas')
            post :update, {:id=>movie.id,:movie => movie_params}
            expect(flash[:notice]).to eq("#{movie_params["title"]} was successfully updated.")
        end
        
    end
    describe '#destroy' do
        it 'should call the model method that destroy a Movie' do
            movie=FactoryGirl.create(:movie,:title =>'title1' ,:director => 'George Lucas')
            expect_any_instance_of(Movie).to receive(:destroy)
            delete :destroy, {:id=>1}
        end
        
        it 'should redirect to homepage'do
            movie=FactoryGirl.create(:movie,:title =>'title1' ,:director => 'George Lucas')
            Movie.stub(:find).and_return(movie)
            delete :destroy, {:id=>movie.id}
            expect(response).to redirect_to(movies_path)
        end

        it 'should display the message deleted.'do
            movie=FactoryGirl.create(:movie,:title =>'title1' ,:director => 'George Lucas')
            delete :destroy, {:id=>movie.id}
            expect(flash[:notice]).to eq("Movie '#{movie.title}' deleted.")
        end
        
    end
    describe 'find a movie' do
      it 'should show the movie information' do
        movie=FactoryGirl.create(:movie,:title =>'title1' ,:director => 'George Lucas')
        Movie.stub(:find).and_return(movie)
        get :show, {:id => movie.id}
        response.should render_template('show')
      end
    end
    describe 'edit a movie' do
      it 'should show the form to edit the movie information' do
        movie=FactoryGirl.create(:movie,:title =>'title1' ,:director => 'George Lucas')
        Movie.stub(:find).and_return(movie)
        get :edit, {:id => movie.id}
        response.should render_template('edit')
      end
    end

  describe 'list all movies' do
    it 'should find list all movies, sort by title' do
      get :index, {:sort => 'title', :ratings => 'PG'}
      response.should redirect_to(:sort => 'title', :ratings => 'PG')
    end

    it 'should find list all movies, sort by release_date' do
      get :index, {:sort => 'release_date', :ratings => 'PG'}
      response.should redirect_to(:sort => 'release_date', :ratings => 'PG')
    end

    it 'should find list all movies with rating PG' do
      get :index, {:ratings => 'PG'}
      response.should redirect_to(:ratings => 'PG')
    end

  end
end
