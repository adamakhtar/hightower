module Hightower
  class UsersFilter

    def initialize(scope)
      @scope = scope
    end

    def perform(params)
      results = filter_by_label(scope, params)
      results = paginate_results(results, params)
    end

    private

    attr_reader :scope

    def filter_by_label(scope, params)
      return scope if params[:query].blank?
      query = "%#{params[:query]}%"
      scope.where(sql_for_label, query)
    end

    def paginate_results(results, params)
      results.page(params[:page]).per(Hightower.per_page)
    end

    def sql_for_label
      "#{Hightower.user_label_method.to_s} like ?"
    end
  end
end