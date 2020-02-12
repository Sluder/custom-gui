classdef Validator < handle
    
    methods(Static)
        function passedRules = validate(value, rules)
            % Only continue if optional field has rules when not empty
            if contains(rules, 'optional') && isempty(value)
                return
            end
            
            rules = split(rules, '|');
            passedRules = true;
            
            for i = 1:numel(rules)
                rule = rules{i};
                
                if strcmp(rule, 'numeric')
                    passedRules = isnumeric(value);
                    
                elseif strcmp(rule, 'string')
                    passedRules = isstring(value);
                    
                elseif strcmp(rule, 'char')
                    passedRules = ischar(value);
                    
                elseif strcmp(rule, 'required')
                    passedRules = ~isempty(value);
                    
                elseif strcmp(rule, 'regex')
                    expression = split(rule, ':');
                    passedRules = regex_match(value, expression);
                    
                elseif strcmp(rule, 'not_regex')
                    expression = split(rule, ':');
                    passedRules = ~regex_match(value, expression);
                    
                elseif startsWith(rule, 'contains')
                    word = spllit(rule, ':');
                    passedRules = (isstring(value) || ischar(value)) && contains(value, word{2});
                    
                elseif startsWith(rule, 'min')
                    min = split(rule, ':');
                    
                    if ischar(value) || isstring(value)
                        passedRules = strlength(value) >= str2num(min{2});
                    elseif isnumeric(value)
                        passedRules = value >= str2num(min{2});
                    else
                        passedRules = false;
                    end
                elseif startsWith(rule, 'max')
                    max = split(rule, ':');
                    
                    if ischar(value) || isstring(value)
                        passedRules = strlength(value) <= str2num(max{2});
                    elseif isnumeric(value)
                        passedRules = value <= str2num(max{2});
                    else
                        passedRules = false;
                    end
                end
                
                % End if any rule doesnt pass
                if ~passedRules
                    return
                end
            end
        end
    end
    
end

