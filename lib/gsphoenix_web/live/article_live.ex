# lib/your_app_web/live/article_live.ex
defmodule GsphoenixWeb.ArticleLive do
  use GsphoenixWeb, :live_view

  alias Gsphoenix.Content
  alias Gsphoenix.Content.Article

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :articles, list_articles())}
  end

  def handle_params(params, _uri, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  # def handle_event("save", %{"article" => article_params}, socket) do
  #   case Content.create_article(article_params) do
  #     {:ok, article} ->
  #       {:noreply, assign(socket, :articles, list_articles())}
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign(socket, :changeset, changeset)}
  #   end
  # end

  # def handle_event("validate", %{"article" => article_params}, socket) do
  #   changeset = Content.change_article(%Article{}, article_params)
  #   {:noreply, assign(socket, :changeset, changeset)}
  # end

  defp list_articles do
    Content.list_articles()
  end

  defp apply_action(socket, :index, _params) do
    assign(socket, :changeset, Content.change_article(%Article{}))
  end
end