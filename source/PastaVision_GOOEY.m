function varargout = PastaVision_GOOEY(varargin)
%PASTAVISION_GOOEY MATLAB code file for PastaVision_GOOEY.fig
%      PASTAVISION_GOOEY, by itself, creates a new PASTAVISION_GOOEY or raises the existing
%      singleton*.
%
%      H = PASTAVISION_GOOEY returns the handle to a new PASTAVISION_GOOEY or the handle to
%      the existing singleton*.
%
%      PASTAVISION_GOOEY('Property','Value',...) creates a new PASTAVISION_GOOEY using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to PastaVision_GOOEY_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PASTAVISION_GOOEY('CALLBACK') and PASTAVISION_GOOEY('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PASTAVISION_GOOEY.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PastaVision_GOOEY

% Last Modified by GUIDE v2.5 13-Dec-2019 11:16:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PastaVision_GOOEY_OpeningFcn, ...
                   'gui_OutputFcn',  @PastaVision_GOOEY_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before PastaVision_GOOEY is made visible.
function PastaVision_GOOEY_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for PastaVision_GOOEY
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

[file, path] = uigetfile('.mp4', 'Select video file to analyse')
global vobj
global nframes
global duration
global cframe
global scorematrix
vobj = VideoReader([path file]);
nframes = Func_n_frames(vobj);
duration = vobj.Duration;
cframe = 1;
scorematrix = zeros(nframes,16);
scorematrix(:,1)=1;
scorematrix(1,16)=1;
imshow(read(vobj,cframe));
set(handles.Back100,'Enable','off');
set(handles.Back10,'Enable','off');
set(handles.Back1,'Enable','off');
set(handles.Frame_Display,'String', ['Frame ' num2str(cframe) ' of ' num2str(nframes)]);
retrieve_score(handles)

% UIWAIT makes PastaVision_GOOEY wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = PastaVision_GOOEY_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%--------------------------------------------------------------------------
%Navigation buttons--------------------------------------------------------
%--------------------------------------------------------------------------

% --- Executes on button press in Back100.
function Back100_Callback(hObject, eventdata, handles)
global cframe; global vobj; global nframes
update_score(handles)
cframe = cframe - 100;
imshow(read(vobj,cframe))
update_nav_buttons(handles)
retrieve_score(handles)
set(handles.Frame_Display,'String', ['Frame ' num2str(cframe) ' of ' num2str(nframes)]);
% --- Executes on button press in Back10.
function Back10_Callback(hObject, eventdata, handles)
global cframe; global vobj; global nframes
update_score(handles)
cframe = cframe - 10;
imshow(read(vobj,cframe))
update_nav_buttons(handles)
retrieve_score(handles)
set(handles.Frame_Display,'String', ['Frame ' num2str(cframe) ' of ' num2str(nframes)]);
% --- Executes on button press in Back1.
function Back1_Callback(hObject, eventdata, handles)
global cframe; global vobj; global nframes
update_score(handles)
cframe = cframe - 1;
imshow(read(vobj,cframe))
update_nav_buttons(handles)
retrieve_score(handles)
set(handles.Frame_Display,'String', ['Frame ' num2str(cframe) ' of ' num2str(nframes)]);
% --- Executes on button press in Fwd1.
function Fwd1_Callback(hObject, eventdata, handles)
global cframe; global vobj; global nframes
update_score(handles)
cframe = cframe + 1;
imshow(read(vobj,cframe))
update_nav_buttons(handles)
retrieve_score(handles)
set(handles.Frame_Display,'String', ['Frame ' num2str(cframe) ' of ' num2str(nframes)]);
% --- Executes on button press in Fwd10.
function Fwd10_Callback(hObject, eventdata, handles)
global cframe; global vobj; global nframes
update_score(handles)
cframe = cframe + 10;
imshow(read(vobj,cframe))
update_nav_buttons(handles)
retrieve_score(handles)
set(handles.Frame_Display,'String', ['Frame ' num2str(cframe) ' of ' num2str(nframes)]);
% --- Executes on button press in Fwd100.
function Fwd100_Callback(hObject, eventdata, handles)
global cframe; global vobj; global nframes
update_score(handles)
cframe = cframe + 100;
imshow(read(vobj,cframe))
update_nav_buttons(handles)
retrieve_score(handles)
set(handles.Frame_Display,'String', ['Frame ' num2str(cframe) ' of ' num2str(nframes)]);

function update_nav_buttons(handles)
global cframe; global nframes
if cframe < 101
    set(handles.Back100,'Enable','off')
else
    set(handles.Back100,'Enable','on')
end
if cframe < 11
    set(handles.Back10,'Enable','off')
else
    set(handles.Back10,'Enable','on')
end
if cframe == 1
    set(handles.Back1,'Enable','off')
else
    set(handles.Back1,'Enable','on')
end
if nframes-cframe == 0
    set(handles.Fwd1,'Enable','off')
else
    set(handles.Fwd1,'Enable','on')
end
if nframes-cframe < 11 
    set(handles.Fwd10,'Enable','off')
else
    set(handles.Fwd10,'Enable','on')
end
if nframes-cframe < 101 
    set(handles.Fwd100,'Enable','off')
else
    set(handles.Fwd100,'Enable','on')
end

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function update_score(handles)
    global cframe; global scorematrix
    scorematrix(cframe,1) = get(handles.On_Floor_True, 'Value');
    scorematrix(cframe,2) = get(handles.One_Paw_R_True, 'Value');
    scorematrix(cframe,3) = get(handles.One_Paw_L_True, 'Value');
    scorematrix(cframe,4) = get(handles.Asym_R_True, 'Value');
    scorematrix(cframe,5) = get(handles.Asym_L_True, 'Value');
    scorematrix(cframe,6) = get(handles.Sym_Part_True, 'Value');
    scorematrix(cframe,7) = get(handles.Sym_Closed_True, 'Value');
    scorematrix(cframe,8) = get(handles.Left_Sym_Adjust, 'Value');
    scorematrix(cframe,9) = get(handles.Right_Sym_Adjust, 'Value');
    scorematrix(cframe,10) = get(handles.Asym_Guide_Adjust, 'Value');
    scorematrix(cframe,11) = get(handles.Asym_Grip_Adjust, 'Value');
    scorematrix(cframe,12) = get(handles.In_Mouth_True, 'Value');
    scorematrix(cframe,13) = get(handles.Chewing_True, 'Value');
    scorematrix(cframe,14) = get(handles.Break_True, 'Value');
    scorematrix(cframe,15) = get(handles.Pasta_gone, 'Value');
    scorematrix(cframe,16) = 1;
    
    function retrieve_score(handles)
    global cframe; global scorematrix
    if scorematrix(cframe,16) == 1
        set(handles.On_Floor_True, 'Value',scorematrix(cframe,1));
        set(handles.One_Paw_R_True, 'Value', scorematrix(cframe,2));
        set(handles.One_Paw_L_True, 'Value', scorematrix(cframe,3));
        set(handles.Asym_R_True, 'Value', scorematrix(cframe,4));
        set(handles.Asym_L_True, 'Value', scorematrix(cframe,5));
        set(handles.Sym_Part_True, 'Value', scorematrix(cframe,6));
        set(handles.Sym_Closed_True, 'Value',scorematrix(cframe,7));
        set(handles.Left_Sym_Adjust, 'Value', scorematrix(cframe,8));
        set(handles.Right_Sym_Adjust, 'Value', scorematrix(cframe,9));
        set(handles.Asym_Guide_Adjust, 'Value', scorematrix(cframe,10));
        set(handles.Asym_Grip_Adjust, 'Value', scorematrix(cframe,11));
        set(handles.In_Mouth_True, 'Value', scorematrix(cframe,12));
        set(handles.Chewing_True, 'Value', scorematrix(cframe,13));
        set(handles.Break_True, 'Value', scorematrix(cframe,14));
        set(handles.Pasta_gone, 'Value', scorematrix(cframe,15));
    end
    
% --- Executes on button press in Export.
function Export_Callback(hObject, eventdata, handles)
global scorematrix; global duration
update_score(handles)
outpath = uigetdir('Select destination to save output');
outname = [outpath filesep 'output.txt'];
copynum = 1;
while exist(outname) == 2
    outname = [outpath filesep 'output(' num2str(copynum) ').txt'];
    copynum = copynum+1;
end
outmatrix = horzcat(round(linspace(0,duration,numel(scorematrix(:,1)))',3) , scorematrix);
writematrix(outmatrix, outname);


% --- Executes on button press in load_scores.
function load_scores_Callback(hObject, eventdata, handles)
 global scorematrix;
[file, path] = uigetfile('.txt', 'Select scoring data')
 temp = readmatrix([path file]);
 temp = temp(:,2:end);
 if length(temp)==length(scorematrix)
     scorematrix = temp;
     retrieve_score(handles);
 else
     errordlg('Discrepancy between length of loaded and intitial score matrices');
     
 end
% hObject    handle to load_scores (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Break_True.
function Break_True_Callback(hObject, eventdata, handles)
% hObject    handle to Break_True (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Break_True


% --- Executes on button press in Pasta_gone.
function Pasta_gone_Callback(hObject, eventdata, handles)
% hObject    handle to Pasta_gone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Pasta_gone
