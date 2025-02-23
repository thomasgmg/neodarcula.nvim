# Simple task scheduler with priority
from typing import List, Optional
import time


class Task:
    def __init__(self, name: str, priority: int):
        self.name = name
        self.priority = priority

    def execute(self) -> None:
        print(f"Executing {self.name} with priority {self.priority}")


def retry_on_failure(max_attempts: int):
    def decorator(func):
        def wrapper(*args, **kwargs):
            for attempt in range(max_attempts):
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    print(f"Attempt {attempt + 1} failed: {e}")
                    if attempt == max_attempts - 1:
                        raise RuntimeError("Max retries exceeded!")

        return wrapper

    return decorator


class Scheduler:
    def __init__(self):
        self.tasks: List[Task] = []

    @retry_on_failure(max_attempts=3)
    def add_task(self, name: str, priority: int) -> None:
        if priority < 0:
            raise ValueError("Priority must be non-negative")
        task = Task(name, priority)
        self.tasks.append(task)

    def run(self) -> None:
        sorted_tasks = sorted(self.tasks, key=lambda t: t.priority, reverse=True)
        for task in sorted_tasks:
            task.execute()


if __name__ == "__main__":
    sched = Scheduler()
    try:
        sched.add_task("Write docs", 2)
        sched.add_task("Fix bug", 5)
        sched.add_task("Invalid", -1)  # Will raise error
    except (ValueError, RuntimeError) as e:
        print(f"Error: {e}")
    sched.run()
