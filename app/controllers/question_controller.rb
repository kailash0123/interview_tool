class QuestionController < ApplicationController
	before_action :require_login
   def new
      # logger.debug "________________________________________________________"
      # logger.debug $foo.id
      # logger.debug "________________________________________________________"



      @question=Question.new

	 end

   def create
        logger.debug "Creating11111111111111111111111111111111....."
        logger.debug params
        #logger.debug params["question"]["option#{}"]
        logger.debug params["question"][:option1]
        @question = Question.new(question_params)   
        # logger.debug question_params
        
        if @question.save
            (1..4).each do |i|
              
              #@option = Option.new(:question_id => @question.id, :option => params["question"]["option1"])
              @option = Option.new(:question_id => @question.id, :option => params["question"]["option#{i}"])
              @option.save
            end
            #flash[:success] = "new question added"
                if @option.save
                    redirect_to question_path($foo.id)
                else
                    render 'new'
                end
        end
    end
  
    def edit
      @question=Question.find(params[:id])
    end
    
    def update 
      @question =Question.find(params[:id])
       if @question.update_attributes(question_params)
        flash[:success] = "question updated"
        redirect_to question_path($foo.id)

       else
         render 'edit'
       end
    end
    
    def destroy
       @question= Question.find(params[:id])
       @question.destroy
       redirect_to question_path($foo.id)
    end


    def show
       $foo=Category.find(params[:id])
       logger.debug "________________________________________________________"
       logger.debug $foo
       logger.debug "________________________________________________________"
       
       @question=Question.where(:subcategory_id => params[:id])
    end


 private

    def question_params
       params.require(:question).permit(:category, :subcategory_id, :question_level, :question, :answer)
    end

    def option_params
      params.require(:option).permit(:category_id, :option1)
    end

     def require_login
      
        unless signed_in?
         flash[:error] = "You must be logged in to access this section"
         redirect_to login_path # halts request cycle
        end
     end
    
end
