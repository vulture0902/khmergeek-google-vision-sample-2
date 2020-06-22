Rails.application.routes.draw do
  root 'welcome#top'
  get   "top",     to: 'welcome#top'
  post  "upload",  to: 'welcome#upload'
  get   "history", to: 'welcome#history'
end
