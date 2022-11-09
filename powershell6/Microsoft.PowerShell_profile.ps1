Set-location C:\Users\okaki\Desktop

add-type -AssemblyName System.Windows.Forms

<#
キーバインドの設定

関数一覧
Get-PSReadlineKeyHandler | ogv

キーバインド一覧，確認
Ctrl + Alt + ?      (ShowKeyBindings)
Alt + ?             (WhatIsKey)


例
Set-PSReadlineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward

コピペ用
Set-PSReadlineKeyHandler -Key '' -Function 

. $profile で設定の再読み込み可能。


スクリプトブロックへのバインド例
Set-PSReadlineKeyHandler -Chord "Ctrl+q" { [Microsoft.PowerShell.PSConsoleReadLine]::Insert("Hello, World!") }

#>


<# アロー系，削除系 #>
Set-PSReadlineKeyHandler -Key 'Ctrl+k' -Function PreviousHistory
Set-PSReadlineKeyHandler -Key 'Ctrl+n' -Function NextHistory
Set-PSReadlineKeyHandler -Key 'Ctrl+h' -Function BackwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+l' -Function ForwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+u' -Function BeginningOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+e' -Function EndOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+j' -Function BackwardWord
    # b が遠いから j
Set-PSReadlineKeyHandler -Key 'Ctrl+;' -Function NextWord
    # ; は疑問……。ただ他に案が見つからず。

Set-PSReadlineKeyHandler -Key 'Ctrl+d' -Function BackwardDeleteChar


Set-PSReadlineKeyHandler -Key 'Ctrl+w' -Function BackwardKillWord

Set-PSReadlineKeyHandler -Key 'Ctrl+Shift+k' -Function ScrollDisplayUpLine
Set-PSReadlineKeyHandler -Key 'Ctrl+Shift+n' -Function ScrollDisplayDownLine





#補完
Set-PSReadlineKeyHandler -Key 'Ctrl+t' -Function TabCompleteNext;


# cat UTF8

function ca ($fn)
{
    Get-Content $fn -Encoding UTF8;
}

# grep UTF8

function grep ($word){
    ls . *.txt -r | Select-String $word -Encoding UTF8 | %{
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

# エイリアス

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

# 定義

$sendTo = "%APPDATA%\Microsoft\Windows\SendTo" ;

# dl

function dl{
  ls -Directory -Name
}

# "PowreShell の補完とか.txt" 09/26

function maho($ts){
  $ts | % {('$function:{0} = {2} return "{1}" {3}' -f $_[0], $_[1], '{', '}')}
}

function min($a, $b){ if ($a -gt $b){return $b} else {return $a}}
function max($a, $b){ if ($a -lt $b){return $b} else {return $a}}


# (2017/10/23)
# IME を自動で切る
# Set-PSReadlineKeyHandler -Key 'Ctrl+m' -Function AcceptLine

Set-PSReadlineKeyHandler -Chord "Ctrl+m" {
  [System.Windows.Forms.Sendkeys]::Sendwait("^+{F6}")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

# プロフィールを呼ぶ
Set-PSReadlineKeyHandler -Chord "Ctrl+o" {
  vi --remote-silent $PROFILE
}



# (2019/01/14) 動画用

function Stucco($fo)
{
        if ($fo.isDir){ Write-Host $fo.fline -fore Magenta }
        else          { Write-Host $fo.fline }
}

function GetFiles
{
        [System.Array]$dirs  = ls -Directory
        [System.Array]$files = ls -File
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
# 移行を模索中

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


# (2019/06/13)
# password

function passhelp
{
        Write-Host " on `n ag "
}

function pass_conf{ Write-Host "コピーした" }

function pass($name)
{
        switch ($name)
        {
                "on" { "edjt3RgPdQSyjHM" | clip ; pass_conf } 
                "ag" { "Q53mNqZYh7iJSeY" | clip ; pass_conf } 
                "h"  { passhelp }
        }
}


# (2019/06/18)
# gg

function gg($goto)
{
        switch ($goto)
        {
                $null {cd C:\Users\okaki\Desktop}
                "j"   {cd 'E:\j'}
                "m"   {cd 'E:\旧e\永久保存\音楽'}
                "g"   {cd 'E:\games'}
        }
}

#(2020/03/05)

Set-PSReadlineKeyHandler -Chord "Ctrl+." {    explorer .    }

# (2020/08/11)

function randtouch ($number)
{
    $r = random $number
    touch (ls -File | Sort-Object LastAccessTime)[$r]
}


# (2021/03/08)

function home()
{
    vi 'C:\Users\okaki\Desktop\HOME.txt'
}


# vim の起動パターンを模索中 -c と :normal  :excecute を使う。
function memo
{
    $folder = "C:\Users\okaki\Desktop\sou\Zat\@in\"
    $day, $time = (get-date -Format "yyyy-MM-dd.HH:mm") -split '\.'
    $day += ".md"
    vi "$folder/$day" -c 'norm Go' `
      -c ('norm Gxi## {0}' -f (Get-Date -f "HH:mm"))  `
      -c 'norm zz' `
      -c 'norm o'
}
