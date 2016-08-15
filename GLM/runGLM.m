function [beta,betaStruct] = runGLM(Y,X,identities,mapping)
% Handles the GLM act on the data set, and after obtaining betas,
% additionally creates an additional representation where each beta is
% dropped into a struct by the name of its field


% Compute the core GLM
% Perhaps like the cellular GLM, each of the types of data should be
% treated in an insular manner?? Not sure. Maybe try both ways. I think if
% one wants to understand an orthogonalize the different beta sources,
% might be better to "paginate" them, and then from there,

if iscell(X)
    % ---
    for c = 1:size(X)
        
        squareX  = X{c}*X{c}'; %#ok<*AGROW>
        XY       = X{c}*Y;
        beta{c}     = squareX\XY;
        
    end
elseif isnumeric(X)
    
    squareX = X*X';
    XY      = X*Y;
    beta    = squareX\XY;
    
else
    error('Input X improper type!');
end

% If identities and mapping provided, then delineat each of the betas, what
% type of variable it belongs to, and drop it into betaStruct, which keeps
% tabs on who's whos
betaStruct = struct();
if exist('identities','var') && exist('mapping','var')
    
    for item = mapping'
        
        number = item{1};
        name = item{2};
        
        betaStruct.(name) = beta(identities == number);
        
    end
    
end