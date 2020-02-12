classdef Label
    properties
        position
        color
        text
        enabled
    end
    
    properties(Access = protected)
        uiInstance
    end
    
    methods
        function obj = Label()
            obj.uiInstance = uilabel();
        end
        
        function obj = set.color(obj, color)
            obj.uiInstance.FontColor = color;
        end
        
        function obj = set.text(obj, text)
            obj.uiInstance.Text = text;
        end
        
        function obj = set.enabled(obj, isEnabled)
            obj.uiInstance.Enable = isEnabled;
        end
    end
end

