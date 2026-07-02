(globalThis.TURBOPACK||(globalThis.TURBOPACK=[])).push(["object"==typeof document?document.currentScript:void 0,3752,5766,t=>{"use strict";let e,i;var s,r=t.i(71645);let a={data:""},n=/(?:([\u0080-\uFFFF\w-%@]+) *:? *([^{;]+?);|([^;}{]*?) *{)|(}\s*)/g,o=/\/\*[^]*?\*\/|  +/g,u=/\n+/g,c=(t,e)=>{let i="",s="",r="";for(let a in t){let n=t[a];"@"==a[0]?"i"==a[1]?i=a+" "+n+";":s+="f"==a[1]?c(n,a):a+"{"+c(n,"k"==a[1]?"":e)+"}":"object"==typeof n?s+=c(n,e?e.replace(/([^,])+/g,t=>a.replace(/([^,]*:\S+\([^)]*\))|([^,])+/g,e=>/&/.test(e)?e.replace(/&/g,t):t?t+" "+e:e)):a):null!=n&&(a="-"==a[1]?a:a.replace(/[A-Z]/g,"-$&").toLowerCase(),r+=c.p?c.p(a,n):a+":"+n+";")}return i+(e&&r?e+"{"+r+"}":r)+s},l={},d=t=>{if("object"==typeof t){let e="";for(let i in t)e+=i+d(t[i]);return e}return t};function h(t){let e,i,s=this||{},r=t.call?t(s.p):t;return((t,e,i,s,r)=>{var a;let h=d(t),p=l[h]||(l[h]=(t=>{let e=0,i=11;for(;e<t.length;)i=101*i+t.charCodeAt(e++)>>>0;return"go"+i})(h));if(!l[p]){let e=h!==t?t:(t=>{let e,i,s=[{}];for(;e=n.exec(t.replace(o,""));)e[4]?s.shift():e[3]?(i=e[3].replace(u," ").trim(),s.unshift(s[0][i]=s[0][i]||{})):s[0][e[1]]=e[2].replace(u," ").trim();return s[0]})(t);l[p]=c(r?{["@keyframes "+p]:e}:e,i?"":"."+p)}let f=i&&l.g;return i&&(l.g=l[p]),a=l[p],f?e.data=e.data.replace(f,a):-1===e.data.indexOf(a)&&(e.data=s?a+e.data:e.data+a),p})(r.unshift?r.raw?(e=[].slice.call(arguments,1),i=s.p,r.reduce((t,s,r)=>{let a=e[r];if(a&&a.call){let t=a(i),e=t&&t.props&&t.props.className||/^go/.test(t)&&t;a=e?"."+e:t&&"object"==typeof t?t.props?"":c(t,""):!1===t?"":t}return t+s+(null==a?"":a)},"")):r.reduce((t,e)=>Object.assign(t,e&&e.call?e(s.p):e),{}):r,(t=>{if("object"==typeof window){let e=(t?t.querySelector("#_goober"):window._goober)||Object.assign(document.createElement("style"),{innerHTML:" ",id:"_goober"});return e.nonce=window.__nonce__,e.parentNode||(t||document.head).appendChild(e),e.firstChild}return t||a})(s.target),s.g,s.o,s.k)}h.bind({g:1});let p,f,m,y=h.bind({k:1});function v(t,e){let i=this||{};return function(){let s=arguments;function r(a,n){let o=Object.assign({},a),u=o.className||r.className;i.p=Object.assign({theme:f&&f()},o),i.o=/go\d/.test(u),o.className=h.apply(i,s)+(u?" "+u:""),e&&(o.ref=n);let c=t;return t[0]&&(c=o.as||t,delete o.as),m&&c[0]&&m(o),p(c,o)}return e?e(r):r}}var g=(t,e)=>"function"==typeof t?t(e):t,b=(e=0,()=>(++e).toString()),w=()=>{if(void 0===i&&"u">typeof window){let t=matchMedia("(prefers-reduced-motion: reduce)");i=!t||t.matches}return i},S="default",C=(t,e)=>{let{toastLimit:i}=t.settings;switch(e.type){case 0:return{...t,toasts:[e.toast,...t.toasts].slice(0,i)};case 1:return{...t,toasts:t.toasts.map(t=>t.id===e.toast.id?{...t,...e.toast}:t)};case 2:let{toast:s}=e;return C(t,{type:+!!t.toasts.find(t=>t.id===s.id),toast:s});case 3:let{toastId:r}=e;return{...t,toasts:t.toasts.map(t=>t.id===r||void 0===r?{...t,dismissed:!0,visible:!1}:t)};case 4:return void 0===e.toastId?{...t,toasts:[]}:{...t,toasts:t.toasts.filter(t=>t.id!==e.toastId)};case 5:return{...t,pausedAt:e.time};case 6:let a=e.time-(t.pausedAt||0);return{...t,pausedAt:void 0,toasts:t.toasts.map(t=>({...t,pauseDuration:t.pauseDuration+a}))}}},x=[],P={toasts:[],pausedAt:void 0,settings:{toastLimit:20}},T={},O=(t,e=S)=>{T[e]=C(T[e]||P,t),x.forEach(([t,i])=>{t===e&&i(T[e])})},E=t=>Object.keys(T).forEach(e=>O(t,e)),F=(t=S)=>e=>{O(e,t)},j={blank:4e3,error:4e3,success:2e3,loading:1/0,custom:4e3},k=t=>(e,i)=>{let s,r=((t,e="blank",i)=>({createdAt:Date.now(),visible:!0,dismissed:!1,type:e,ariaProps:{role:"status","aria-live":"polite"},message:t,pauseDuration:0,...i,id:(null==i?void 0:i.id)||b()}))(e,t,i);return F(r.toasterId||(s=r.id,Object.keys(T).find(t=>T[t].toasts.some(t=>t.id===s))))({type:2,toast:r}),r.id},M=(t,e)=>k("blank")(t,e);M.error=k("error"),M.success=k("success"),M.loading=k("loading"),M.custom=k("custom"),M.dismiss=(t,e)=>{let i={type:3,toastId:t};e?F(e)(i):E(i)},M.dismissAll=t=>M.dismiss(void 0,t),M.remove=(t,e)=>{let i={type:4,toastId:t};e?F(e)(i):E(i)},M.removeAll=t=>M.remove(void 0,t),M.promise=(t,e,i)=>{let s=M.loading(e.loading,{...i,...null==i?void 0:i.loading});return"function"==typeof t&&(t=t()),t.then(t=>{let r=e.success?g(e.success,t):void 0;return r?M.success(r,{id:s,...i,...null==i?void 0:i.success}):M.dismiss(s),t}).catch(t=>{let r=e.error?g(e.error,t):void 0;r?M.error(r,{id:s,...i,...null==i?void 0:i.error}):M.dismiss(s)}),t};var R=1e3,q=y`
from {
  transform: scale(0) rotate(45deg);
	opacity: 0;
}
to {
 transform: scale(1) rotate(45deg);
  opacity: 1;
}`,A=y`
from {
  transform: scale(0);
  opacity: 0;
}
to {
  transform: scale(1);
  opacity: 1;
}`,D=y`
from {
  transform: scale(0) rotate(90deg);
	opacity: 0;
}
to {
  transform: scale(1) rotate(90deg);
	opacity: 1;
}`,I=v("div")`
  width: 20px;
  opacity: 0;
  height: 20px;
  border-radius: 10px;
  background: ${t=>t.primary||"#ff4b4b"};
  position: relative;
  transform: rotate(45deg);

  animation: ${q} 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275)
    forwards;
  animation-delay: 100ms;

  &:after,
  &:before {
    content: '';
    animation: ${A} 0.15s ease-out forwards;
    animation-delay: 150ms;
    position: absolute;
    border-radius: 3px;
    opacity: 0;
    background: ${t=>t.secondary||"#fff"};
    bottom: 9px;
    left: 4px;
    height: 2px;
    width: 12px;
  }

  &:before {
    animation: ${D} 0.15s ease-out forwards;
    animation-delay: 180ms;
    transform: rotate(90deg);
  }
`,U=y`
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
`,$=v("div")`
  width: 12px;
  height: 12px;
  box-sizing: border-box;
  border: 2px solid;
  border-radius: 100%;
  border-color: ${t=>t.secondary||"#e0e0e0"};
  border-right-color: ${t=>t.primary||"#616161"};
  animation: ${U} 1s linear infinite;
`,L=y`
from {
  transform: scale(0) rotate(45deg);
	opacity: 0;
}
to {
  transform: scale(1) rotate(45deg);
	opacity: 1;
}`,K=y`
0% {
	height: 0;
	width: 0;
	opacity: 0;
}
40% {
  height: 0;
	width: 6px;
	opacity: 1;
}
100% {
  opacity: 1;
  height: 10px;
}`,N=v("div")`
  width: 20px;
  opacity: 0;
  height: 20px;
  border-radius: 10px;
  background: ${t=>t.primary||"#61d345"};
  position: relative;
  transform: rotate(45deg);

  animation: ${L} 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275)
    forwards;
  animation-delay: 100ms;
  &:after {
    content: '';
    box-sizing: border-box;
    animation: ${K} 0.2s ease-out forwards;
    opacity: 0;
    animation-delay: 200ms;
    position: absolute;
    border-right: 2px solid;
    border-bottom: 2px solid;
    border-color: ${t=>t.secondary||"#fff"};
    bottom: 6px;
    left: 6px;
    height: 10px;
    width: 6px;
  }
`,G=v("div")`
  position: absolute;
`,z=v("div")`
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  min-width: 20px;
  min-height: 20px;
`,H=y`
from {
  transform: scale(0.6);
  opacity: 0.4;
}
to {
  transform: scale(1);
  opacity: 1;
}`,Q=v("div")`
  position: relative;
  transform: scale(0.6);
  opacity: 0.4;
  min-width: 20px;
  animation: ${H} 0.3s 0.12s cubic-bezier(0.175, 0.885, 0.32, 1.275)
    forwards;
`,B=({toast:t})=>{let{icon:e,type:i,iconTheme:s}=t;return void 0!==e?"string"==typeof e?r.createElement(Q,null,e):e:"blank"===i?null:r.createElement(z,null,r.createElement($,{...s}),"loading"!==i&&r.createElement(G,null,"error"===i?r.createElement(I,{...s}):r.createElement(N,{...s})))},_=v("div")`
  display: flex;
  align-items: center;
  background: #fff;
  color: #363636;
  line-height: 1.3;
  will-change: transform;
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1), 0 3px 3px rgba(0, 0, 0, 0.05);
  max-width: 350px;
  pointer-events: auto;
  padding: 8px 10px;
  border-radius: 8px;
`,Z=v("div")`
  display: flex;
  justify-content: center;
  margin: 4px 10px;
  color: inherit;
  flex: 1 1 auto;
  white-space: pre-line;
`,V=r.memo(({toast:t,position:e,style:i,children:s})=>{let a=t.height?((t,e)=>{let i=t.includes("top")?1:-1,[s,r]=w()?["0%{opacity:0;} 100%{opacity:1;}","0%{opacity:1;} 100%{opacity:0;}"]:[`
0% {transform: translate3d(0,${-200*i}%,0) scale(.6); opacity:.5;}
100% {transform: translate3d(0,0,0) scale(1); opacity:1;}
`,`
0% {transform: translate3d(0,0,-1px) scale(1); opacity:1;}
100% {transform: translate3d(0,${-150*i}%,-1px) scale(.6); opacity:0;}
`];return{animation:e?`${y(s)} 0.35s cubic-bezier(.21,1.02,.73,1) forwards`:`${y(r)} 0.4s forwards cubic-bezier(.06,.71,.55,1)`}})(t.position||e||"top-center",t.visible):{opacity:0},n=r.createElement(B,{toast:t}),o=r.createElement(Z,{...t.ariaProps},g(t.message,t));return r.createElement(_,{className:t.className,style:{...a,...i,...t.style}},"function"==typeof s?s({icon:n,message:o}):r.createElement(r.Fragment,null,n,o))});s=r.createElement,c.p=void 0,p=s,f=void 0,m=void 0;var J=({id:t,className:e,style:i,onHeightUpdate:s,children:a})=>{let n=r.useCallback(e=>{if(e){let i=()=>{s(t,e.getBoundingClientRect().height)};i(),new MutationObserver(i).observe(e,{subtree:!0,childList:!0,characterData:!0})}},[t,s]);return r.createElement("div",{ref:n,className:e,style:i},a)},W=h`
  z-index: 9999;
  > * {
    pointer-events: auto;
  }
`;t.s(["Toaster",0,({reverseOrder:t,position:e="top-center",toastOptions:i,gutter:s,children:a,toasterId:n,containerStyle:o,containerClassName:u})=>{let{toasts:c,handlers:l}=((t,e="default")=>{let{toasts:i,pausedAt:s}=((t={},e=S)=>{let[i,s]=(0,r.useState)(T[e]||P),a=(0,r.useRef)(T[e]);(0,r.useEffect)(()=>(a.current!==T[e]&&s(T[e]),x.push([e,s]),()=>{let t=x.findIndex(([t])=>t===e);t>-1&&x.splice(t,1)}),[e]);let n=i.toasts.map(e=>{var i,s,r;return{...t,...t[e.type],...e,removeDelay:e.removeDelay||(null==(i=t[e.type])?void 0:i.removeDelay)||(null==t?void 0:t.removeDelay),duration:e.duration||(null==(s=t[e.type])?void 0:s.duration)||(null==t?void 0:t.duration)||j[e.type],style:{...t.style,...null==(r=t[e.type])?void 0:r.style,...e.style}}});return{...i,toasts:n}})(t,e),a=(0,r.useRef)(new Map).current,n=(0,r.useCallback)((t,e=R)=>{if(a.has(t))return;let i=setTimeout(()=>{a.delete(t),o({type:4,toastId:t})},e);a.set(t,i)},[]);(0,r.useEffect)(()=>{if(s)return;let t=Date.now(),r=i.map(i=>{if(i.duration===1/0)return;let s=(i.duration||0)+i.pauseDuration-(t-i.createdAt);if(s<0){i.visible&&M.dismiss(i.id);return}return setTimeout(()=>M.dismiss(i.id,e),s)});return()=>{r.forEach(t=>t&&clearTimeout(t))}},[i,s,e]);let o=(0,r.useCallback)(F(e),[e]),u=(0,r.useCallback)(()=>{o({type:5,time:Date.now()})},[o]),c=(0,r.useCallback)((t,e)=>{o({type:1,toast:{id:t,height:e}})},[o]),l=(0,r.useCallback)(()=>{s&&o({type:6,time:Date.now()})},[s,o]),d=(0,r.useCallback)((t,e)=>{let{reverseOrder:s=!1,gutter:r=8,defaultPosition:a}=e||{},n=i.filter(e=>(e.position||a)===(t.position||a)&&e.height),o=n.findIndex(e=>e.id===t.id),u=n.filter((t,e)=>e<o&&t.visible).length;return n.filter(t=>t.visible).slice(...s?[u+1]:[0,u]).reduce((t,e)=>t+(e.height||0)+r,0)},[i]);return(0,r.useEffect)(()=>{i.forEach(t=>{if(t.dismissed)n(t.id,t.removeDelay);else{let e=a.get(t.id);e&&(clearTimeout(e),a.delete(t.id))}})},[i,n]),{toasts:i,handlers:{updateHeight:c,startPause:u,endPause:l,calculateOffset:d}}})(i,n);return r.createElement("div",{"data-rht-toaster":n||"",style:{position:"fixed",zIndex:9999,top:16,left:16,right:16,bottom:16,pointerEvents:"none",...o},className:u,onMouseEnter:l.startPause,onMouseLeave:l.endPause},c.map(i=>{let n,o,u=i.position||e,c=l.calculateOffset(i,{reverseOrder:t,gutter:s,defaultPosition:e}),d=(n=u.includes("top"),o=u.includes("center")?{justifyContent:"center"}:u.includes("right")?{justifyContent:"flex-end"}:{},{left:0,right:0,display:"flex",position:"absolute",transition:w()?void 0:"all 230ms cubic-bezier(.21,1.02,.73,1)",transform:`translateY(${c*(n?1:-1)}px)`,...n?{top:0}:{bottom:0},...o});return r.createElement(J,{id:i.id,key:i.id,onHeightUpdate:l.updateHeight,className:i.visible?W:"",style:d},"custom"===i.type?g(i.message,i):a?a(i):r.createElement(V,{toast:i,position:u}))}))},"default",0,M],5766);let X=new Map,Y=[[/security check failed/i,"Security check failed."],[/authentication required|not logged in|please log in/i,"Please sign in."],[/session expired/i,"Session expired. Sign in again."],[/activate your account|requires activation/i,"Activate your account first."],[/failed to fetch|connection error|network/i,"Connection error. Try again."],[/could not be loaded|failed to load/i,"Could not load data."],[/could not be saved|failed to update|update failed/i,"Could not save changes."],[/failed to remove/i,"Could not remove item."],[/failed to delete/i,"Could not delete item."],[/failed to submit|could not be submitted/i,"Could not submit."],[/insufficient xec/i,"Not enough XEC."],[/already reported/i,"Already reported."],[/rate limit|too many/i,"Please wait and try again."]],tt=t=>{if("function"==typeof t)return t;let e=t&&"object"==typeof t&&(t.requestId||t.clientRequestId||t.response?.requestId)||"",i=(t=>{if("string"!=typeof t)return t;let e=t.replace(/^error:\s*/i,"").replace(/^http error!\s*status:\s*\d+\s*/i,"").replace(/^http\s*\d+:\s*/i,"").replace(/\s+/g," ").trim(),i=Y.find(([t])=>t.test(e));return i?i[1]:e.length<=80?e:`${e.slice(0,77).trim()}...`})(t instanceof Error?t.message:t)||"Something went wrong.";return e?`${i} Request ID: ${e}`:i},te=(t={})=>{let e=t&&"object"==typeof t?t:{};return{duration:e.duration??2600,...e}},ti=(t,e,i,s)=>{let r=tt(i),a=te(s);if(!a.id&&"string"==typeof r){let i=`${t}:${r}`,s=Date.now(),n=X.get(i);if(n&&s-n.at<1400)return n.id;let o=e(r,a);return X.set(i,{id:o,at:s}),setTimeout(()=>{let t=X.get(i);t?.id===o&&X.delete(i)},5600),o}return e(r,a)},ts=(t,e)=>ti("default",(t,e)=>M(t,e),t,e);ts.success=(t,e)=>ti("success",(t,e)=>M.success(t,e),t,e),ts.error=(t,e)=>ti("error",(t,e)=>M.error(t,e),t,e),ts.info=(t,e)=>ti("info",(t,e)=>M(t,e),t,e),ts.loading=(t,e)=>M.loading(tt(t),te(e)),ts.promise=(t,e,i)=>M.promise(t,{loading:tt(e?.loading||"Loading..."),success:t=>tt("function"==typeof e?.success?e.success(t):e?.success),error:t=>tt("function"==typeof e?.error?e.error(t):e?.error)},te(i)),ts.dismiss=M.dismiss,ts.remove=M.remove,ts.custom=M.custom,t.s(["default",()=>ts],3752)},80166,t=>{"use strict";t.i(47167);var e={setTimeout:(t,e)=>setTimeout(t,e),clearTimeout:t=>clearTimeout(t),setInterval:(t,e)=>setInterval(t,e),clearInterval:t=>clearInterval(t)},i=new class{#t=e;#e=!1;setTimeoutProvider(t){this.#t=t}setTimeout(t,e){return this.#t.setTimeout(t,e)}clearTimeout(t){this.#t.clearTimeout(t)}setInterval(t,e){return this.#t.setInterval(t,e)}clearInterval(t){this.#t.clearInterval(t)}};t.s(["systemSetTimeoutZero",0,function(t){setTimeout(t,0)},"timeoutManager",0,i])},19273,t=>{"use strict";t.i(47167);var e=t.i(80166),i="u"<typeof window||"Deno"in globalThis;function s(t,e){return(e?.queryKeyHashFn||r)(t)}function r(t){return JSON.stringify(t,(t,e)=>u(e)?Object.keys(e).sort().reduce((t,i)=>(t[i]=e[i],t),{}):e)}function a(t,e){return t===e||typeof t==typeof e&&!!t&&!!e&&"object"==typeof t&&"object"==typeof e&&Object.keys(e).every(i=>a(t[i],e[i]))}var n=Object.prototype.hasOwnProperty;function o(t){return Array.isArray(t)&&t.length===Object.keys(t).length}function u(t){if(!c(t))return!1;let e=t.constructor;if(void 0===e)return!0;let i=e.prototype;return!!c(i)&&!!i.hasOwnProperty("isPrototypeOf")&&Object.getPrototypeOf(t)===Object.prototype}function c(t){return"[object Object]"===Object.prototype.toString.call(t)}var l=Symbol();t.s(["addConsumeAwareSignal",0,function(t,e,i){let s,r=!1;return Object.defineProperty(t,"signal",{enumerable:!0,get:()=>(s??=e(),r||(r=!0,s.aborted?i():s.addEventListener("abort",i,{once:!0})),s)}),t},"addToEnd",0,function(t,e,i=0){let s=[...t,e];return i&&s.length>i?s.slice(1):s},"addToStart",0,function(t,e,i=0){let s=[e,...t];return i&&s.length>i?s.slice(0,-1):s},"ensureQueryFn",0,function(t,e){return!t.queryFn&&e?.initialPromise?()=>e.initialPromise:t.queryFn&&t.queryFn!==l?t.queryFn:()=>Promise.reject(Error(`Missing queryFn: '${t.queryHash}'`))},"functionalUpdate",0,function(t,e){return"function"==typeof t?t(e):t},"hashKey",0,r,"hashQueryKeyByOptions",0,s,"isServer",0,i,"isValidTimeout",0,function(t){return"number"==typeof t&&t>=0&&t!==1/0},"matchMutation",0,function(t,e){let{exact:i,status:s,predicate:n,mutationKey:o}=t;if(o){if(!e.options.mutationKey)return!1;if(i){if(r(e.options.mutationKey)!==r(o))return!1}else if(!a(e.options.mutationKey,o))return!1}return(!s||e.state.status===s)&&(!n||!!n(e))},"matchQuery",0,function(t,e){let{type:i="all",exact:r,fetchStatus:n,predicate:o,queryKey:u,stale:c}=t;if(u){if(r){if(e.queryHash!==s(u,e.options))return!1}else if(!a(e.queryKey,u))return!1}if("all"!==i){let t=e.isActive();if("active"===i&&!t||"inactive"===i&&t)return!1}return("boolean"!=typeof c||e.isStale()===c)&&(!n||n===e.state.fetchStatus)&&(!o||!!o(e))},"noop",0,function(){},"partialMatchKey",0,a,"replaceData",0,function(t,e,i){return"function"==typeof i.structuralSharing?i.structuralSharing(t,e):!1!==i.structuralSharing?function t(e,i,s=0){if(e===i)return e;if(s>500)return i;let r=o(e)&&o(i);if(!r&&!(u(e)&&u(i)))return i;let a=(r?e:Object.keys(e)).length,c=r?i:Object.keys(i),l=c.length,d=r?Array(l):{},h=0;for(let o=0;o<l;o++){let u=r?o:c[o],l=e[u],p=i[u];if(l===p){d[u]=l,(r?o<a:n.call(e,u))&&h++;continue}if(null===l||null===p||"object"!=typeof l||"object"!=typeof p){d[u]=p;continue}let f=t(l,p,s+1);d[u]=f,f===l&&h++}return a===l&&h===a?e:d}(t,e):e},"resolveQueryBoolean",0,function(t,e){return"function"==typeof t?t(e):t},"resolveStaleTime",0,function(t,e){return"function"==typeof t?t(e):t},"shallowEqualObjects",0,function(t,e){if(!e||Object.keys(t).length!==Object.keys(e).length)return!1;for(let i in t)if(t[i]!==e[i])return!1;return!0},"shouldThrowError",0,function(t,e){return"function"==typeof t?t(...e):!!t},"skipToken",0,l,"sleep",0,function(t){return new Promise(i=>{e.timeoutManager.setTimeout(i,t)})},"timeUntilStale",0,function(t,e){return Math.max(t+(e||0)-Date.now(),0)}])},40143,t=>{"use strict";let e,i,s,r,a,n;var o=t.i(80166).systemSetTimeoutZero,u=(e=[],i=0,s=t=>{t()},r=t=>{t()},a=o,{batch:t=>{let n;i++;try{n=t()}finally{let t;--i||(t=e,e=[],t.length&&a(()=>{r(()=>{t.forEach(t=>{s(t)})})}))}return n},batchCalls:t=>(...e)=>{n(()=>{t(...e)})},schedule:n=t=>{i?e.push(t):a(()=>{s(t)})},setNotifyFunction:t=>{s=t},setBatchNotifyFunction:t=>{r=t},setScheduler:t=>{a=t}});t.s(["notifyManager",0,u])},75555,15823,t=>{"use strict";var e=class{constructor(){this.listeners=new Set,this.subscribe=this.subscribe.bind(this)}subscribe(t){return this.listeners.add(t),this.onSubscribe(),()=>{this.listeners.delete(t),this.onUnsubscribe()}}hasListeners(){return this.listeners.size>0}onSubscribe(){}onUnsubscribe(){}};t.s(["Subscribable",0,e],15823);var i=new class extends e{#i;#s;#r;constructor(){super(),this.#r=t=>{if("u">typeof window&&window.addEventListener){let e=()=>t();return window.addEventListener("visibilitychange",e,!1),()=>{window.removeEventListener("visibilitychange",e)}}}}onSubscribe(){this.#s||this.setEventListener(this.#r)}onUnsubscribe(){this.hasListeners()||(this.#s?.(),this.#s=void 0)}setEventListener(t){this.#r=t,this.#s?.(),this.#s=t(t=>{"boolean"==typeof t?this.setFocused(t):this.onFocus()})}setFocused(t){this.#i!==t&&(this.#i=t,this.onFocus())}onFocus(){let t=this.isFocused();this.listeners.forEach(e=>{e(t)})}isFocused(){return"boolean"==typeof this.#i?this.#i:globalThis.document?.visibilityState!=="hidden"}};t.s(["focusManager",0,i],75555)},81991,t=>{"use strict";var e=t.i(15823),i=new class extends e.Subscribable{#a=!0;#s;#r;constructor(){super(),this.#r=t=>{if("u">typeof window&&window.addEventListener){let e=()=>t(!0),i=()=>t(!1);return window.addEventListener("online",e,!1),window.addEventListener("offline",i,!1),()=>{window.removeEventListener("online",e),window.removeEventListener("offline",i)}}}}onSubscribe(){this.#s||this.setEventListener(this.#r)}onUnsubscribe(){this.hasListeners()||(this.#s?.(),this.#s=void 0)}setEventListener(t){this.#r=t,this.#s?.(),this.#s=t(this.setOnline.bind(this))}setOnline(t){this.#a!==t&&(this.#a=t,this.listeners.forEach(e=>{e(t)}))}isOnline(){return this.#a}};t.s(["onlineManager",0,i])},93803,t=>{"use strict";var e=t.i(19273);t.s(["pendingThenable",0,function(){let t,e,i=new Promise((i,s)=>{t=i,e=s});function s(t){Object.assign(i,t),delete i.resolve,delete i.reject}return i.status="pending",i.catch(()=>{}),i.resolve=e=>{s({status:"fulfilled",value:e}),t(e)},i.reject=t=>{s({status:"rejected",reason:t}),e(t)},i},"tryResolveSync",0,function(t){let i;if(t.then(t=>(i=t,t),e.noop)?.catch(e.noop),void 0!==i)return{data:i}}])},73911,t=>{"use strict";let e;var i=t.i(19273),s=(e=()=>i.isServer,{isServer:()=>e(),setIsServer(t){e=t}});t.s(["environmentManager",0,s])},36553,t=>{"use strict";var e=t.i(75555),i=t.i(81991),s=t.i(93803),r=t.i(73911),a=t.i(19273);function n(t){return Math.min(1e3*2**t,3e4)}function o(t){return(t??"online")!=="online"||i.onlineManager.isOnline()}var u=class extends Error{constructor(t){super("CancelledError"),this.revert=t?.revert,this.silent=t?.silent}};t.s(["CancelledError",0,u,"canFetch",0,o,"createRetryer",0,function(t){let c,l=!1,d=0,h=(0,s.pendingThenable)(),p=()=>e.focusManager.isFocused()&&("always"===t.networkMode||i.onlineManager.isOnline())&&t.canRun(),f=()=>o(t.networkMode)&&t.canRun(),m=t=>{"pending"===h.status&&(c?.(),h.resolve(t))},y=t=>{"pending"===h.status&&(c?.(),h.reject(t))},v=()=>new Promise(e=>{c=t=>{("pending"!==h.status||p())&&e(t)},t.onPause?.()}).then(()=>{c=void 0,"pending"===h.status&&t.onContinue?.()}),g=()=>{let e;if("pending"!==h.status)return;let i=0===d?t.initialPromise:void 0;try{e=i??t.fn()}catch(t){e=Promise.reject(t)}Promise.resolve(e).then(m).catch(e=>{if("pending"!==h.status)return;let i=t.retry??3*!r.environmentManager.isServer(),s=t.retryDelay??n,o="function"==typeof s?s(d,e):s,u=!0===i||"number"==typeof i&&d<i||"function"==typeof i&&i(d,e);l||!u?y(e):(d++,t.onFail?.(d,e),(0,a.sleep)(o).then(()=>p()?void 0:v()).then(()=>{l?y(e):g()}))})};return{promise:h,status:()=>h.status,cancel:e=>{if("pending"===h.status){let i=new u(e);y(i),t.onCancel?.(i)}},continue:()=>(c?.(),h),cancelRetry:()=>{l=!0},continueRetry:()=>{l=!1},canStart:f,start:()=>(f()?g():v().then(g),h)}}])},88587,t=>{"use strict";var e=t.i(80166),i=t.i(73911),s=t.i(19273),r=class{#n;destroy(){this.clearGcTimeout()}scheduleGc(){this.clearGcTimeout(),(0,s.isValidTimeout)(this.gcTime)&&(this.#n=e.timeoutManager.setTimeout(()=>{this.optionalRemove()},this.gcTime))}updateGcTime(t){this.gcTime=Math.max(this.gcTime||0,t??(i.environmentManager.isServer()?1/0:3e5))}clearGcTimeout(){void 0!==this.#n&&(e.timeoutManager.clearTimeout(this.#n),this.#n=void 0)}};t.s(["Removable",0,r])},14272,t=>{"use strict";var e=t.i(40143),i=t.i(88587),s=t.i(36553),r=class extends i.Removable{#o;#u;#c;#l;constructor(t){super(),this.#o=t.client,this.mutationId=t.mutationId,this.#c=t.mutationCache,this.#u=[],this.state=t.state||a(),this.setOptions(t.options),this.scheduleGc()}setOptions(t){this.options=t,this.updateGcTime(this.options.gcTime)}get meta(){return this.options.meta}addObserver(t){this.#u.includes(t)||(this.#u.push(t),this.clearGcTimeout(),this.#c.notify({type:"observerAdded",mutation:this,observer:t}))}removeObserver(t){this.#u=this.#u.filter(e=>e!==t),this.scheduleGc(),this.#c.notify({type:"observerRemoved",mutation:this,observer:t})}optionalRemove(){this.#u.length||("pending"===this.state.status?this.scheduleGc():this.#c.remove(this))}continue(){return this.#l?.continue()??this.execute(this.state.variables)}async execute(t){let e=()=>{this.#d({type:"continue"})},i={client:this.#o,meta:this.options.meta,mutationKey:this.options.mutationKey};this.#l=(0,s.createRetryer)({fn:()=>this.options.mutationFn?this.options.mutationFn(t,i):Promise.reject(Error("No mutationFn found")),onFail:(t,e)=>{this.#d({type:"failed",failureCount:t,error:e})},onPause:()=>{this.#d({type:"pause"})},onContinue:e,retry:this.options.retry??0,retryDelay:this.options.retryDelay,networkMode:this.options.networkMode,canRun:()=>this.#c.canRun(this)});let r="pending"===this.state.status,a=!this.#l.canStart();try{if(r)e();else{this.#d({type:"pending",variables:t,isPaused:a}),this.#c.config.onMutate&&await this.#c.config.onMutate(t,this,i);let e=await this.options.onMutate?.(t,i);e!==this.state.context&&this.#d({type:"pending",context:e,variables:t,isPaused:a})}let s=await this.#l.start();return await this.#c.config.onSuccess?.(s,t,this.state.context,this,i),await this.options.onSuccess?.(s,t,this.state.context,i),await this.#c.config.onSettled?.(s,null,this.state.variables,this.state.context,this,i),await this.options.onSettled?.(s,null,t,this.state.context,i),this.#d({type:"success",data:s}),s}catch(e){try{await this.#c.config.onError?.(e,t,this.state.context,this,i)}catch(t){Promise.reject(t)}try{await this.options.onError?.(e,t,this.state.context,i)}catch(t){Promise.reject(t)}try{await this.#c.config.onSettled?.(void 0,e,this.state.variables,this.state.context,this,i)}catch(t){Promise.reject(t)}try{await this.options.onSettled?.(void 0,e,t,this.state.context,i)}catch(t){Promise.reject(t)}throw this.#d({type:"error",error:e}),e}finally{this.#c.runNext(this)}}#d(t){this.state=(e=>{switch(t.type){case"failed":return{...e,failureCount:t.failureCount,failureReason:t.error};case"pause":return{...e,isPaused:!0};case"continue":return{...e,isPaused:!1};case"pending":return{...e,context:t.context,data:void 0,failureCount:0,failureReason:null,error:null,isPaused:t.isPaused,status:"pending",variables:t.variables,submittedAt:Date.now()};case"success":return{...e,data:t.data,failureCount:0,failureReason:null,error:null,status:"success",isPaused:!1};case"error":return{...e,data:void 0,error:t.error,failureCount:e.failureCount+1,failureReason:t.error,isPaused:!1,status:"error"}}})(this.state),e.notifyManager.batch(()=>{this.#u.forEach(e=>{e.onMutationUpdate(t)}),this.#c.notify({mutation:this,type:"updated",action:t})})}};function a(){return{context:void 0,data:void 0,error:null,failureCount:0,failureReason:null,isPaused:!1,status:"idle",variables:void 0,submittedAt:0}}t.s(["Mutation",0,r,"getDefaultState",0,a])},86491,92571,t=>{"use strict";var e=t.i(19273),i=t.i(40143),s=t.i(36553),r=t.i(88587);function a(t){return{onFetch:(i,s)=>{let r=i.options,a=i.fetchOptions?.meta?.fetchMore?.direction,u=i.state.data?.pages||[],c=i.state.data?.pageParams||[],l={pages:[],pageParams:[]},d=0,h=async()=>{let s=!1,h=(0,e.ensureQueryFn)(i.options,i.fetchOptions),p=async(t,r,a)=>{let n;if(s)return Promise.reject(i.signal.reason);if(null==r&&t.pages.length)return Promise.resolve(t);let o=(n={client:i.client,queryKey:i.queryKey,pageParam:r,direction:a?"backward":"forward",meta:i.options.meta},(0,e.addConsumeAwareSignal)(n,()=>i.signal,()=>s=!0),n),u=await h(o),{maxPages:c}=i.options,l=a?e.addToStart:e.addToEnd;return{pages:l(t.pages,u,c),pageParams:l(t.pageParams,r,c)}};if(a&&u.length){let t="backward"===a,e={pages:u,pageParams:c},i=(t?o:n)(r,e);l=await p(e,i,t)}else{let e=t??u.length;do{let t=0===d?c[0]??r.initialPageParam:n(r,l);if(d>0&&null==t)break;l=await p(l,t),d++}while(d<e)}return l};i.options.persister?i.fetchFn=()=>i.options.persister?.(h,{client:i.client,queryKey:i.queryKey,meta:i.options.meta,signal:i.signal},s):i.fetchFn=h}}}function n(t,{pages:e,pageParams:i}){let s=e.length-1;return e.length>0?t.getNextPageParam(e[s],e,i[s],i):void 0}function o(t,{pages:e,pageParams:i}){return e.length>0?t.getPreviousPageParam?.(e[0],e,i[0],i):void 0}t.s(["hasNextPage",0,function(t,e){return!!e&&null!=n(t,e)},"hasPreviousPage",0,function(t,e){return!!e&&!!t.getPreviousPageParam&&null!=o(t,e)},"infiniteQueryBehavior",0,a],92571);var u=class extends r.Removable{#h;#p;#f;#m;#o;#l;#y;#v;constructor(t){super(),this.#v=!1,this.#y=t.defaultOptions,this.setOptions(t.options),this.observers=[],this.#o=t.client,this.#m=this.#o.getQueryCache(),this.queryKey=t.queryKey,this.queryHash=t.queryHash,this.#p=d(this.options),this.state=t.state??this.#p,this.scheduleGc()}get meta(){return this.options.meta}get queryType(){return this.#h}get promise(){return this.#l?.promise}setOptions(t){if(this.options={...this.#y,...t},t?._type&&(this.#h=t._type),this.updateGcTime(this.options.gcTime),this.state&&void 0===this.state.data){let t=d(this.options);void 0!==t.data&&(this.setState(l(t.data,t.dataUpdatedAt)),this.#p=t)}}optionalRemove(){this.observers.length||"idle"!==this.state.fetchStatus||this.#m.remove(this)}setData(t,i){let s=(0,e.replaceData)(this.state.data,t,this.options);return this.#d({data:s,type:"success",dataUpdatedAt:i?.updatedAt,manual:i?.manual}),s}setState(t){this.#d({type:"setState",state:t})}cancel(t){let i=this.#l?.promise;return this.#l?.cancel(t),i?i.then(e.noop).catch(e.noop):Promise.resolve()}destroy(){super.destroy(),this.cancel({silent:!0})}get resetState(){return this.#p}reset(){this.destroy(),this.setState(this.resetState)}isActive(){return this.observers.some(t=>!1!==(0,e.resolveQueryBoolean)(t.options.enabled,this))}isDisabled(){return this.getObserversCount()>0?!this.isActive():this.options.queryFn===e.skipToken||!this.isFetched()}isFetched(){return this.state.dataUpdateCount+this.state.errorUpdateCount>0}isStatic(){return this.getObserversCount()>0&&this.observers.some(t=>"static"===(0,e.resolveStaleTime)(t.options.staleTime,this))}isStale(){return this.getObserversCount()>0?this.observers.some(t=>t.getCurrentResult().isStale):void 0===this.state.data||this.state.isInvalidated}isStaleByTime(t=0){return void 0===this.state.data||"static"!==t&&(!!this.state.isInvalidated||!(0,e.timeUntilStale)(this.state.dataUpdatedAt,t))}onFocus(){let t=this.observers.find(t=>t.shouldFetchOnWindowFocus());t?.refetch({cancelRefetch:!1}),this.#l?.continue()}onOnline(){let t=this.observers.find(t=>t.shouldFetchOnReconnect());t?.refetch({cancelRefetch:!1}),this.#l?.continue()}addObserver(t){this.observers.includes(t)||(this.observers.push(t),this.clearGcTimeout(),this.#m.notify({type:"observerAdded",query:this,observer:t}))}removeObserver(t){this.observers.includes(t)&&(this.observers=this.observers.filter(e=>e!==t),this.observers.length||(this.#l&&(this.#v||this.#g()?this.#l.cancel({revert:!0}):this.#l.cancelRetry()),this.scheduleGc()),this.#m.notify({type:"observerRemoved",query:this,observer:t}))}getObserversCount(){return this.observers.length}#g(){return"paused"===this.state.fetchStatus&&"pending"===this.state.status}invalidate(){this.state.isInvalidated||this.#d({type:"invalidate"})}async fetch(t,i){let r;if("idle"!==this.state.fetchStatus&&this.#l?.status()!=="rejected"){if(void 0!==this.state.data&&i?.cancelRefetch)this.cancel({silent:!0});else if(this.#l)return this.#l.continueRetry(),this.#l.promise}if(t&&this.setOptions(t),!this.options.queryFn){let t=this.observers.find(t=>t.options.queryFn);t&&this.setOptions(t.options)}let n=new AbortController,o=t=>{Object.defineProperty(t,"signal",{enumerable:!0,get:()=>(this.#v=!0,n.signal)})},u=()=>{let t,s=(0,e.ensureQueryFn)(this.options,i),r=(o(t={client:this.#o,queryKey:this.queryKey,meta:this.meta}),t);return(this.#v=!1,this.options.persister)?this.options.persister(s,r,this):s(r)},c=(o(r={fetchOptions:i,options:this.options,queryKey:this.queryKey,client:this.#o,state:this.state,fetchFn:u}),r),l="infinite"===this.#h?a(this.options.pages):this.options.behavior;l?.onFetch(c,this),this.#f=this.state,("idle"===this.state.fetchStatus||this.state.fetchMeta!==c.fetchOptions?.meta)&&this.#d({type:"fetch",meta:c.fetchOptions?.meta}),this.#l=(0,s.createRetryer)({initialPromise:i?.initialPromise,fn:c.fetchFn,onCancel:t=>{t instanceof s.CancelledError&&t.revert&&this.setState({...this.#f,fetchStatus:"idle"}),n.abort()},onFail:(t,e)=>{this.#d({type:"failed",failureCount:t,error:e})},onPause:()=>{this.#d({type:"pause"})},onContinue:()=>{this.#d({type:"continue"})},retry:c.options.retry,retryDelay:c.options.retryDelay,networkMode:c.options.networkMode,canRun:()=>!0});try{let t=await this.#l.start();if(void 0===t)throw Error(`${this.queryHash} data is undefined`);return this.setData(t),this.#m.config.onSuccess?.(t,this),this.#m.config.onSettled?.(t,this.state.error,this),t}catch(t){if(t instanceof s.CancelledError){if(t.silent)return this.#l.promise;else if(t.revert){if(void 0===this.state.data)throw t;return this.state.data}}throw this.#d({type:"error",error:t}),this.#m.config.onError?.(t,this),this.#m.config.onSettled?.(this.state.data,t,this),t}finally{this.scheduleGc()}}#d(t){let e=e=>{switch(t.type){case"failed":return{...e,fetchFailureCount:t.failureCount,fetchFailureReason:t.error};case"pause":return{...e,fetchStatus:"paused"};case"continue":return{...e,fetchStatus:"fetching"};case"fetch":return{...e,...c(e.data,this.options),fetchMeta:t.meta??null};case"success":let i={...e,...l(t.data,t.dataUpdatedAt),dataUpdateCount:e.dataUpdateCount+1,...!t.manual&&{fetchStatus:"idle",fetchFailureCount:0,fetchFailureReason:null}};return this.#f=t.manual?i:void 0,i;case"error":let s=t.error;return{...e,error:s,errorUpdateCount:e.errorUpdateCount+1,errorUpdatedAt:Date.now(),fetchFailureCount:e.fetchFailureCount+1,fetchFailureReason:s,fetchStatus:"idle",status:"error",isInvalidated:!0};case"invalidate":return{...e,isInvalidated:!0};case"setState":return{...e,...t.state}}};this.state=e(this.state),i.notifyManager.batch(()=>{this.observers.forEach(t=>{t.onQueryUpdate()}),this.#m.notify({query:this,type:"updated",action:t})})}};function c(t,e){return{fetchFailureCount:0,fetchFailureReason:null,fetchStatus:(0,s.canFetch)(e.networkMode)?"fetching":"paused",...void 0===t&&{error:null,status:"pending"}}}function l(t,e){return{data:t,dataUpdatedAt:e??Date.now(),error:null,isInvalidated:!1,status:"success"}}function d(t){let e="function"==typeof t.initialData?t.initialData():t.initialData,i=void 0!==e,s=i?"function"==typeof t.initialDataUpdatedAt?t.initialDataUpdatedAt():t.initialDataUpdatedAt:0;return{data:e,dataUpdateCount:0,dataUpdatedAt:i?s??Date.now():0,error:null,errorUpdateCount:0,errorUpdatedAt:0,fetchFailureCount:0,fetchFailureReason:null,fetchMeta:null,isInvalidated:!1,status:i?"success":"pending",fetchStatus:"idle"}}t.s(["Query",0,u,"fetchState",0,c],86491)}]);