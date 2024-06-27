require IEx
defmodule GsphoenixWeb.ArticleFormComponent do
  use GsphoenixWeb, :live_component
  alias Gsphoenix.Content
  alias Gsphoenix.Content.Article
  @articles_topic "articles"

  @impl true
  def update(%{article: article} = assigns, socket) do
    changeset = Content.change_article(article)
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"article" => article_params}, socket) do
    changeset =
      socket.assigns.article
      |> Content.change_article(article_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("create_article", %{"article" => article_params}, socket) do
    save_article(socket, article_params)
  end

  defp save_article(socket, article_params) do
    case Content.create_article(article_params) do
      {:ok, _article} ->
        socket =
          assign(socket, items: Content.list_articles())
          |> assign(:changeset, Content.change_article(%Article{}))

        GsphoenixWeb.Endpoint.broadcast(@articles_topic, "articles_updated", socket.assigns)
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
