# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :require_login, only: [:create]
  
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)

    if current_user
      @comment.author_name = current_user.name_user
    else
      @comment.author_name = params[:author_name] || "Anônimo"
    end

    if @comment.save
      redirect_to @article, notice: "Comentário enviado com sucesso!"
    else
      redirect_to @article, alert: "Falha ao enviar o comentário."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author_name, :body)
  end
end