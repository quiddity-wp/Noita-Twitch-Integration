-- name = "A can of worms",
-- desc = "But why?",
function twitch_worm_can()
    for i = 1, 10 do
        spawn_item("data/entities/animals/worm_tiny.xml", 50, 200)
    end
end