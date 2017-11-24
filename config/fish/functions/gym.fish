# for openai gym

function select-gym -d "select openai gym env"
    python -c "import gym; import pybullet_envs; print(\"\n\".join([spec.id for spec in gym.envs.registry.all()]))" | fzf
end
