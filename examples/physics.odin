package main

import "core:fmt"
import "core:math"

// 2D Vector type
Vector2 :: struct {
    x, y: f32,
}

Particle :: struct {
    position: Vector2,
    velocity: Vector2,
}

simulate :: proc(p: ^Particle, dt: f32) {
    p.position.x += p.velocity.x * dt;
    p.position.y += p.velocity.y * dt;
    if p.position.y < 0 {
        p.velocity.y = -p.velocity.y; // Bounce
        fmt.println("Bounce at", p.position);
    }
}

main :: proc() {
    particle := Particle{
        position = Vector2{0, 10},
        velocity = Vector2{2, -5},
    };
    dt := 0.1;
    for i in 0..10 {
        simulate(&particle, dt);
        fmt.printf("Position: (%.2f, %.2f)\n", particle.position.x, particle.position.y);
    }
}
