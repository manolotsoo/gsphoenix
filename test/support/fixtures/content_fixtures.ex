defmodule Gsphoenix.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Gsphoenix.Content` context.
  """

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> Gsphoenix.Content.create_article()

    article
  end
end
