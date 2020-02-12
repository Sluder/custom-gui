classdef Validator < handle
    % Possible rules delimited by '|'
    % numeric   : Must be a number
    % string    : Must be of type string
    % char      : Must be of type char
    % required  : Must not be empty
    % optional  : Nullable, but checked when other rules are provided
    % regex     : Must match regex
    % not_regex : Must not match regex
    % contains  : Must be string/char, and contain a certain word
    % min       : Min value for a number, or string/char length
    % max       : Max value for a number, or string/char length
    %
    % Example : 'min:5|contains:text'
    
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
                    word = word{2};
                    passedRules = (isstring(value) || ischar(value)) && contains(value, word);
                    
                elseif startsWith(rule, 'min')
                    min = split(rule, ':');
                    min = min{2};
                    
                    if ischar(value) || isstring(value)
                        passedRules = strlength(value) >= str2double(min);
                    elseif isnumeric(value)
                        passedRules = value >= str2double(min);
                    else
                        passedRules = false;
                    end
                elseif startsWith(rule, 'max')
                    max = split(rule, ':');
                    max = max{2};
                    
                    if ischar(value) || isstring(value)
                        passedRules = strlength(value) <= str2double(max);
                    elseif isnumeric(value)
                        passedRules = value <= str2double(max);
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

