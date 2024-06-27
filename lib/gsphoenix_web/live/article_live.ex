defmodule GsphoenixWeb.ArticleLive do
  use GsphoenixWeb, :live_view

  alias Gsphoenix.Content
  alias Gsphoenix.Content.Article
  @articles_topic "articles"

  def mount(_params, _session, socket) do
    if connected?(socket), do: GsphoenixWeb.Endpoint.subscribe(@articles_topic)
    {:ok, socket
     |> assign(:articles, list_articles())
     |> assign_article()
     |> assign(:changeset, Content.change_article(%Article{}))}
  end

  def handle_params(params, _uri, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def assign_article(socket) do
    socket
    |> assign(:article, %Article{})
  end

  def handle_info(%{event: "articles_updated", payload: %{items: items}}, socket) do
    {:noreply, assign(socket, :articles, items)}
  end

  defp list_articles do
    Content.list_articles()
  end

  defp apply_action(socket, :index, _params) do
    assign(socket, :changeset, Content.change_article(%Article{}))
  end
end
