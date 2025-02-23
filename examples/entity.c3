#include <stdio.h>

// Component-based entity
struct Position {
    float x, y;
}

struct Entity {
    Position pos;
    int id;
}

fn void move(Entity* e, float dx, float dy) {
    e->pos.x += dx;
    e->pos.y += dy;
    printf("Moved to (%f, %f)\n", e->pos.x, e->pos.y);
}

fn Entity create_entity(int id, float x, float y) {
    Entity e = { .pos = {x, y}, .id = id };
    if (id < 0) {
        fprintf(stderr, "Invalid ID: %d\n", id);
        exit(1);
    }
    return e;
}

fn int main() {
    Entity entity = create_entity(1, 0.0, 0.0);
    move(&entity, 5.0, 3.0);
    return 0;
}
