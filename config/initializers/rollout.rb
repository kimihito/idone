require 'redis'

$redis   = Redis.new
$rollout = Rollout.new($redis)