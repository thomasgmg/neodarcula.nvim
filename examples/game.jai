#import "Basic";

Game :: struct {
    running: bool;
    frame_count: u32;
}

update :: (game: *Game) {
    game.frame_count += 1;
    if game.frame_count > 100 {
        game.running = false;
        print("Game ended after % frames.\n", game.frame_count);
    }
}

main :: () -> s32 {
    game := Game { running = true, frame_count = 0 };
    while game.running {
        update(&game);
        print("Frame: %\n", game.frame_count);
    }
    return 0;
}
