function gh-peco-checkout-pull-request
    set --local PR_ID (gh pr list | peco | awk '{ print $1 }')
    gh pr checkout $PR_ID
end


function gh-peco-view-pull-request
    set --local PR_ID (gh pr list | peco | awk '{ print $1 }')
    gh pr view $PR_ID
end
