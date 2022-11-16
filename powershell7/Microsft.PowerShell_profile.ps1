# (2019/10/18)
# Core 6 �Ɉڍs���悤���l���n�߂�B

Set-location C:\Users\okaki\Desktop

# �G���R�[�f�B���O
[System.Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("utf-8")
[System.Console]::InputEncoding = [System.Text.Encoding]::GetEncoding("utf-8")

# git log�Ȃǂ̃}���`�o�C�g������\�������邽�� (�G�����܂�)
$env:LESSCHARSET = "utf-8"

# �A�Z���u���n�Ńo�O�p�o�B Ctrl+m ���o�O��B
# 
# <#
# �L�[�o�C���h�̐ݒ�
# 
# �֐��ꗗ
# Get-PSReadlineKeyHandler | ogv
# 
# �L�[�o�C���h�ꗗ�C�m�F
# Ctrl + Alt + ?      (ShowKeyBindings)
# Alt + ?             (WhatIsKey)
# 
# 
# ��
# Set-PSReadlineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
# 
# �R�s�y�p
# Set-PSReadlineKeyHandler -Key '' -Function 
# 
# . $profile �Őݒ�̍ēǂݍ��݉\�B
# 
# 
# �X�N���v�g�u���b�N�ւ̃o�C���h��
# Set-PSReadlineKeyHandler -Chord "Ctrl+q" { [Microsoft.PowerShell.PSConsoleReadLine]::Insert("Hello, World!") }
# 
#>


<# �A���[�n�C�폜�n #>
Set-PSReadlineKeyHandler -Key 'Ctrl+k' -Function PreviousHistory
Set-PSReadlineKeyHandler -Key 'Ctrl+n' -Function NextHistory
Set-PSReadlineKeyHandler -Key 'Ctrl+h' -Function BackwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+l' -Function ForwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+u' -Function BeginningOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+e' -Function EndOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+j' -Function BackwardWord
    # b ���������� j
Set-PSReadlineKeyHandler -Key 'Ctrl+;' -Function NextWord
    # ; �͋^��c�c�B�������ɈĂ������炸�B
Set-PSReadlineKeyHandler -Key 'Ctrl+m' -Function AcceptLine

Set-PSReadlineKeyHandler -Key 'Ctrl+d' -Function BackwardDeleteChar


Set-PSReadlineKeyHandler -Key 'Ctrl+w' -Function BackwardKillWord

Set-PSReadlineKeyHandler -Key 'Ctrl+Shift+k' -Function ScrollDisplayUpLine
Set-PSReadlineKeyHandler -Key 'Ctrl+Shift+n' -Function ScrollDisplayDownLine
#�⊮
Set-PSReadlineKeyHandler -Key 'Ctrl+t' -Function TabCompleteNext;

# �v���t�B�[�����Ă� # �Ȃ��� ver7 ����g���Ȃ�
Set-PSReadlineKeyHandler -Chord "Ctrl+o" {
  vi --remote-silent $PROFILE
}

# ����ő�p
function co{
  vi --remote-silent $PROFILE
}


# cat UTF8

function ca ($fn)
{
    Get-Content $fn -Encoding UTF8;
}

# grep UTF8

function grep ($word){
    ls | ?{$_.Extension -in @(".txt", ".md")} | 
       Select-String $word -Encoding UTF8 | %{
       Write-Host $_.Filename -ForegroundColor DarkGray;
       Write-Host $_.Line "`r`n";
    }
}

# prompt
# (Get-PSReadlineOption)

function prompt
{
    "`
 Monapo :: $($executionContext.SessionState.Path.CurrentLocation)` 
>> ";

}

# �G�C���A�X

Set-Alias put Write-Host;
Set-Alias gt Get-Member;

# find

function find ([string]$word){
    # Get-Item *$word*
    Get-Item *$word* | Sort-Object -Descending LastWriteTime;
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile";
}

# ��`

$sendTo = "%APPDATA%\Microsoft\Windows\SendTo" ;

# dl

function dl{
  ls -Directory -Name
}

# "PowreShell �̕⊮�Ƃ�.txt" 09/26

function maho($ts){
  $ts | % {('$function:{0} = {2} return "{1}" {3}' -f $_[0], $_[1], '{', '}')}
}

function min($a, $b){ if ($a -gt $b){return $b} else {return $a}}
function max($a, $b){ if ($a -lt $b){return $b} else {return $a}}


# (2019/01/14) ����p

function Stucco($fo)
{
        if ($fo.isDir){ Write-Host $fo.fline -fore Magenta }
        else          { Write-Host $fo.fline }
}

function GetFiles
{
        [System.Array]$dirs  = ls | ?{$_.PSisContainer}
        [System.Array]$files = ls | ?{!$_.PSisContainer} |
                                        Sort -D LastWriteTime
        return ($dirs + $files) | select `
               @{name="fline";expression={fileObjctToFomatedString $_}},
               @{name="isDir";expression={$_.PSisContainer}}
}

function fileObjctToFomatedString($fo)
{
        " {0}   {1}" -F ($fo.LastWriteTime.ToShortDateString()),
                           ($fo.name)
}

function td
{
        Getfiles | %{Stucco $_}
}

# (2019/01/31)
# �ڍs��͍���

function touch($_file){
  $a = (Get-Item $_file)
  $a.LastAccessTime = Date
  &($a.FullName)
}

function ta{
  ls -File | Sort-Object LastAccessTime | Select-Object LastAccessTime, Name -First 25
}

function kl{
  $a = ls -File | Sort-Object LastAccessTime | Select-Object -First 1
  $a.LastAccessTime = Date
  &($a.Fullname)
}


# (2019/06/18)
# gg

function gg($goto)
{
        switch ($goto)
        {
                $null {cd C:\Users\okaki\Desktop}
                "j"   {cd E:\j}
                "m"   {cd 'E:\��e\�i�v�ۑ�\���y'}
        }
}

# (2021/01/21)

# function soto() {Invoke-RestMethod http://wttr.in/osaka?lang=ja}
function soto() {(Invoke-RestMethod http://wttr.in/osaka?lang=ja).substring(0,380)}

function dive
{ 
    $date = (date).Date.ToString().Substring(0,10)
    $dirname = $date -replace '/', '_'
    cd (mkdir $dirname)
}

# ��[�킩��񂯂ǁC mpv �̂���t�H���_�� portable_config �����B
# $mpv_conf  = "C:\mpv\portable_config\input.conf"
# $mpv_input = "C:\mpv\portable_config\mpv.conf"
$mpv_conf = "C:\Users\okaki\AppData\Roaming\mpv\input.conf"
$mpv_input = "C:\Users\okaki\AppData\Roaming\mpv\mpv.conf"

# vim �̋N���p�^�[����͍��� -c �� :normal  :excecute ���g���B
function memo
{
    $folder = "C:\Users\okaki\Desktop\sou\Zat\@in\"
    # $folder = "C:\Users\okaki\Desktop\vim\daily\"
    $day, $time = (get-date -Format "yyyy-MM-dd.HH:mm") -split '\.'
    $day += ".md"
    ## �� -c "xi## $time" ~ �� x �́CGo �ŏo�����S�p�X�y�[�X�폜���邽�߁B
    vi "$folder/$day" -c 'norm Go' `
      -c "norm xi## $time" `
      -c 'norm zz' `
}

# (2021/02/17)

function home()
{
    vi 'C:\Users\okaki\Desktop\HOME.txt'
}

# (2021/09/12)
#
function going_to($fp)
{
    cd $fp
    explorer.exe .
    if (Test-Path ./README.txt) { cat ./README.txt}
}

# (2021/10/26)

function vimfiles{explorer "C:\Users\okaki\vimfiles"}


# (2022/07/14)
# image ����
# ������ �摜�t�@�C����S�āC ../image/ (�����쐬) �Ɉړ�����B

function bunri()
{
    # �f�B���N�g���[�Ɉړ����Ă���g��
    $ext = @(".jpg", ".jpeg", ".JPG", ".JPEG", ".png", ".gif")
    $imagefolder = "image"
    $fp = (pwd).Path
    mkdir $imagefolder -Force
    ls -LiteralPath $fp                 |
        ?{$_.Extension -in $ext}        | 
        %{mi -LiteralPath $_.Fullname $imagefolder}
}

## (2022/08/03)
## Obsidian �� Obsidian Vault �p memo�֐�
## memoma �p�� �֐��͕ʓr�p�ӂ���\��B

function ovu
{
    $folder = "C:\Users\okaki\Desktop\Obsidian\Monthly"
    $month, $day, $time = (get-date -Format "yyyy-MM.dd.HH:mm") -split '\.'
    $month += ".md"
    vi "$folder/$month" -c 'norm Go' `
      -c "norm xi## $time" `
      -c 'norm zz' `
}

## (2022/10/04)

## �e�X�g�p
# function memo2
# {
#     $folder = "C:\Users\okaki\Desktop\vim\daily\"
#     $Year = (get-date -Format "yyyy")
# 	$name = "$Year" + "Diary.md"
#     vi "$folder/$name" -c ':normal call Myvim_Timestamp()
# }
#
#

# (2022/11/16)
# git �p

function ga ()
{
    git add .
    git status
}

Remove-Alias gm -Force  # ���\��������C����܂���������Ȃ����ǁB
Remove-Alias gl -Force  # gl = pwd
function gm ($str)
{
    if ($str -eq $null){
        git commit
    }else{
        git commit -m $str
    }
    git stage
}

function gl ($opt)
{
    if ($opt -eq 'n'){
        git log --name-status --date=format:'%Y-%m-%d %H:%M' --pretty=format:"%C(cyan)%cd %Cgreen[%cr]`n  %s`n"
    }else{
        git log --date=format:'%Y-%m-%d %H:%M' --pretty=format:"%C(cyan)%cd %Cgreen[%cr]`n  %s`n"
    }
}
