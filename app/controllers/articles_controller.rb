class ArticlesController < ApplicationController
  
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @articles = Article.all
  end

  def new
    @article= Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
	@article = Article.find(params[:id])
	 
	if @article.update(article_params)
	    redirect_to @article
	else
	    render 'edit'
     end
  end

  def create
  	# Try with this minimal renering first
  	#render plain: params[:article].inspect

  	# Avoid using strong parameters such as params.require(:article).permit(:title, :text)
  	#@article = Article.new(params[:article])

    # This is permitted instead of strong paramemers
  	#params.require(:article).permit(:title, :text)

  	# But the article prameters can be factored out into its own method
  	# Such as def article_params in its private scope

    @article = Article.new(article_params)

    # validation is in place 
    # @article.save fails if validation returns an error
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
 
    redirect_to articles_path
  end

 private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
