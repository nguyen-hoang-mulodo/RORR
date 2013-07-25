class BlogsController < ApplicationController

  def index
    #checkLogin
	@title = "Manager Blogs"

	@blogsList = Blog.paginate(:page => params[:page],:per_page => 5).order('updated_at DESC')
  end

  def new
    @title = "Create Blog"
    if checkLogin

      @blog = params[:blog]
      @error = nil

      unless @blog.nil?
        @createBlog = Blog.create(params.require(:blog).permit(:title,:content))

        unless @createBlog.valid?
          @blog = Blog.new(params[:blog])
          @error = @createBlog.errors
        else
          redirect_to "/blogs"
        end

      end

	end
  end

  def edit
    if checkLogin
	  @title = "Edit Blog"

	  begin
		@blog = Blog.find(params[:id])
	  rescue ActiveRecord::RecordNotFound => e
		render(:text => "Not found")
	  end

	  @error = nil

	  unless params[:blog].nil?
		@updateBlog = Blog.update(params[:id],params.require(:blog).permit(:title,:content))

		unless @updateBlog.valid?
		  @error = @updateBlog.errors
		else
		  redirect_to "/blogs"
		end

	  end

	end
  end

  def detail

	begin
      @blog = Blog.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render(:text => "Not found")
    end

    @title = @blog.title
    @meta_keywords = @blog.title

  end

end
