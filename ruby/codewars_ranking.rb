class User
  attr_accessor :progress, :rank

  @@ranks = [(-8..-1).to_a, (1..8).to_a].flatten
  
  def initialize progress = 0, rank = -8
    @progress = progress
    @rank = rank
  end

  def increase_progress(task_rank)
    return unless @@ranks.include?(task_rank)
    is_lower = task_rank < @rank
    difference = (@rank - task_rank).abs
    return if @rank == 8 or (is_lower and difference > 1)

    if task_rank == @rank
      @progress += 3
    elsif difference == 1 and is_lower
      @progress += 1
    else
      @progress += 10 * difference * difference
    end

    ranks, progress = @progress.divmod(100)
    ranks.times { @rank = @@ranks[@@ranks.index(@rank) + 1] }
    @progress = progress
  end
end

test_user = User.new
p test_user.rank # -8
p test_user.progress # 0

test_user.increase_progress(-7)
p test_user.progress # 10

test_user.increase_progress(-5)
p test_user.progress # 0
p test_user.rank # -7
