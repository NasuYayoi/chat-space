class UsersController < ApplicationController

  def index
    # GroupIdがない時（グループ新規作成時）
    if (params[:groupId] == "")
      @users = User.where('(name LIKE(?)) and (id != ?)', "%#{params[:keyword]}%", "#{current_user.id}")
    # GroupIdがある時（グループ編集時）
    else
      # 編集するグループのidを変数に入れる
      @group = Group.find(params[:groupId])
      # グループに所属するユーザのidを変数に入れる
      @ids = @group.users.ids
      # メンバー追加のテキストフィールドに表示されるユーザをwhereで条件検索する。インクリメンタルサーチの時に表示される。
      @users = User.where.not(id:@ids).where('(name LIKE(?)) and (id != ?)', "%#{params[:keyword]}%", "#{current_user.id}")
    end

    respond_to do |format|
      format.json
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
