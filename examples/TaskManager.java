import java.util.ArrayList;
import java.util.List;

// Manages a list of tasks with priority levels
public class TaskManager {
    private List<Task> tasks = new ArrayList<>();
    private static final int MAX_TASKS = 100;

    enum Priority {
        LOW, MEDIUM, HIGH
    }

    static class Task {
        String description;
        Priority priority;

        Task(String desc, Priority prio) {
            this.description = desc;
            this.priority = prio;
        }
    }

    public void addTask(String desc, Priority priority) throws IllegalStateException {
        if (tasks.size() >= MAX_TASKS) {
            throw new IllegalStateException("Task limit exceeded!");
        }
        tasks.add(new Task(desc, priority));
        System.out.println("Added: " + desc);
    }

    public void processTasks() {
        for (Task task : tasks) {
            switch (task.priority) {
                case HIGH:
                    System.out.println("Urgent: " + task.description);
                    break;
                case MEDIUM:
                    processMediumTask(task);
                    break;
                default:
                    System.out.println("Later: " + task.description);
            }
        }
    }

    private void processMediumTask(Task task) {
        System.out.println("Processing medium: " + task.description);
    }

    public static void main(String[] args) {
        TaskManager manager = new TaskManager();
        try {
            manager.addTask("Write code", Priority.HIGH);
            manager.addTask("Test app", Priority.MEDIUM);
            manager.addTask("Relax", Priority.LOW);
            manager.processTasks();
        } catch (IllegalStateException e) {
            System.err.println("Error: " + e.getMessage());
        }
    }
}
