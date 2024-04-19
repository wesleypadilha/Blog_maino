# app/controllers/articles_controller.rb 
class ArticlesController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    @articles = Article.order(created_at: :desc).paginate(page: params[:page], per_page: 3)
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to @article, notice: "Artigo criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article, notice: "Artigo atualizado com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, notice: "Artigo excluído com sucesso!"
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end