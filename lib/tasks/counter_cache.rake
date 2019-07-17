namespace :counter_cache do
  desc "Update task counter for all instructions with incomplete tasks"
  task refresh_instruction_tasks: :environment do
    Instruction.refresh_task_counts
  end
end
