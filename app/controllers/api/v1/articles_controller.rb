module Api
    module V1
        class ArticlesController < ApplicationController
            def index
                articles = Article.order('created_at DESC')
                render json: {status: 'success', message: 'Loaded Successfully', data: articles}, status: :ok 
            end

            def show
                article = Article.find(params[:id])
                render json: { status: 'success', message: 'Loaded Successfully', data: article }, status: :ok
            end

            def create
                article = Article.new(article_params)
                if article.save
                    render json: { status: 'success', message: 'Saved Successfully', data: article }, status: :ok
                else
                    render json: { status: 'error', message: 'Article not saved', data: article.errors }, status: :unprocessable_entity
                end
            end

            def destroy
                article = Article.find(params[:id])
                article.destroy
                render json: { status: 'success', message: 'Article deleted' },status: :ok
            end
            
            def update
                article = Article.find(params[:id])
                if article.update_attributes(article_params)
                    render json: { status: 'success', message: 'Article updated', data: article }, status: :ok
                else
                    render json: { status: 'error', message: 'Article not updated', data: article.errors }, status: :unprocessable_entity
                end
            end
            
            private def article_params
                params.permit(:title, :body)
            end

        end
    end
end
