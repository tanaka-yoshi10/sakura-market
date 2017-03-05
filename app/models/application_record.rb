class ApplicationRecord < ActiveRecord::Base
  # [review] 以下の設定が必要になった理由が知りたいです。
  # また、それをコメントに書いてあると良いと思います。
  self.abstract_class = true
end
