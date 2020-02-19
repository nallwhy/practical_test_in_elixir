defmodule PragTest.SeedGenerator do
  alias PragTest.Repo

  def seed_for_tags(tags) do
    if tags[:settings] do
      insert_settings()
    end
  end

  defp insert_settings() do
    # insert(:setting, %{key: "email.mem_welcome_template_id", text_val: "template_id_0"})
    # insert(:setting, %{key: "email.mem_confirm_template_id", text_val: "template_id_1"})
  end
end
